//! Lazy dynamic-plugin loader.
//!
//! At startup the loader only reads `plugins/manifest.toml` from each
//! configured directory and builds an `extension → manifest entry` map.
//! The dylib for a given language is `dlopen`ed only when a file with that
//! extension is first encountered; the SHA-256 in the manifest is verified
//! before the library is opened.
//!
//! Plugin directories (in priority order):
//!
//! 1. Comma-separated entries in `$GRAPHY_PLUGIN_PATH`
//! 2. `$XDG_DATA_HOME/graphy/plugins/` (`~/Library/Application Support/...` on macOS)
//! 3. `./graphy-plugins/` (relative to cwd)
//! 4. `<exe-dir>/plugins/` (alongside the binary — release bundle layout)

use std::collections::HashMap;
use std::ffi::CStr;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex, OnceLock};

use anyhow::{Context, Result, anyhow};
use graphy_plugin_api::{ABI_VERSION, GraphyPluginExtractResult, STATUS_OK};
use libloading::{Library, Symbol};
use tracing::{debug, warn};

use crate::manifest::{Manifest, PluginEntry, sha256_of};
use crate::schema::ExtractionOutput;

type AbiVersionFn = unsafe extern "C" fn() -> u32;
type ExtractFn = unsafe extern "C" fn(
    path_utf8: *const core::ffi::c_char,
    path_len: usize,
    src: *const u8,
    src_len: usize,
) -> GraphyPluginExtractResult;
type FreeFn = unsafe extern "C" fn(GraphyPluginExtractResult);

#[derive(Clone)]
struct EntryWithDir {
    dir: PathBuf,
    entry: PluginEntry,
}

struct LoadedPlugin {
    _library: Library,
    extract: ExtractFn,
    free: FreeFn,
}

#[derive(Clone, Default)]
pub struct PluginRegistry {
    inner: Arc<RegistryInner>,
}

#[derive(Default)]
struct RegistryInner {
    /// Map from file extension (lowercase, no dot) to a manifest entry +
    /// the directory it came from. Resolved at startup.
    by_ext: HashMap<String, EntryWithDir>,
    /// Lazily-populated cache of opened dylibs, keyed by file name. Wrapped
    /// in a Mutex so the registry remains `Send + Sync` for use behind a
    /// `OnceLock`.
    loaded: Mutex<HashMap<String, Arc<LoadedPlugin>>>,
}

impl PluginRegistry {
    /// Process-wide lazily-initialized registry. The first call discovers
    /// plugins and parses their manifests; the libraries themselves are
    /// only opened on demand.
    pub fn global() -> &'static PluginRegistry {
        static REG: OnceLock<PluginRegistry> = OnceLock::new();
        REG.get_or_init(|| match Self::load_from_default_paths() {
            Ok(r) => r,
            Err(e) => {
                warn!(error = %e, "plugin discovery failed; running without plugins");
                PluginRegistry::default()
            }
        })
    }

    pub fn load_from_default_paths() -> Result<Self> {
        Self::load_from(&default_search_paths())
    }

    pub fn load_from(dirs: &[PathBuf]) -> Result<Self> {
        let mut by_ext: HashMap<String, EntryWithDir> = HashMap::new();
        for dir in dirs {
            if !dir.is_dir() {
                continue;
            }
            let Some(manifest) = Manifest::try_load(dir) else {
                debug!(dir = %dir.display(), "no manifest.toml; skipping directory");
                continue;
            };
            if manifest.abi_version != ABI_VERSION {
                warn!(
                    dir = %dir.display(),
                    manifest_abi = manifest.abi_version,
                    host_abi = ABI_VERSION,
                    "manifest ABI mismatch; skipping",
                );
                continue;
            }
            for entry in manifest.plugins {
                for ext in &entry.extensions {
                    let key = ext.to_ascii_lowercase();
                    if by_ext.contains_key(&key) {
                        debug!(ext = %key, name = %entry.name, "extension already claimed; ignoring duplicate");
                        continue;
                    }
                    by_ext.insert(
                        key,
                        EntryWithDir {
                            dir: dir.clone(),
                            entry: entry.clone(),
                        },
                    );
                }
            }
        }
        Ok(Self {
            inner: Arc::new(RegistryInner {
                by_ext,
                loaded: Mutex::new(HashMap::new()),
            }),
        })
    }

    pub fn is_empty(&self) -> bool {
        self.inner.by_ext.is_empty()
    }

    pub fn plugin_count(&self) -> usize {
        // Distinct plugin file names registered.
        let mut seen = std::collections::HashSet::new();
        for v in self.inner.by_ext.values() {
            seen.insert(&v.entry.file);
        }
        seen.len()
    }

    pub fn extensions(&self) -> Vec<String> {
        let mut e: Vec<String> = self.inner.by_ext.keys().cloned().collect();
        e.sort();
        e
    }

    /// Snapshot of registered manifest entries, sorted by name.
    pub fn entries(&self) -> Vec<PluginEntry> {
        let mut seen = std::collections::HashSet::new();
        let mut out = Vec::new();
        for v in self.inner.by_ext.values() {
            if seen.insert(v.entry.file.clone()) {
                out.push(v.entry.clone());
            }
        }
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }

    /// `Some(Ok(...))` if a plugin handled the file; `Some(Err)` if the
    /// plugin errored; `None` if no plugin claims the extension.
    pub fn extract(&self, path: &Path) -> Option<Result<ExtractionOutput>> {
        let ext = path
            .extension()
            .and_then(|s| s.to_str())
            .map(|s| s.to_ascii_lowercase())?;
        let target = self.inner.by_ext.get(&ext)?.clone();
        Some(self.invoke(target, path))
    }

    fn invoke(&self, target: EntryWithDir, path: &Path) -> Result<ExtractionOutput> {
        let plugin = self.load_or_get(&target)?;
        let source = std::fs::read(path).with_context(|| format!("read {}", path.display()))?;
        let path_str = path.to_string_lossy();
        let path_bytes = path_str.as_bytes();
        let result = unsafe {
            (plugin.extract)(
                path_bytes.as_ptr() as *const core::ffi::c_char,
                path_bytes.len(),
                source.as_ptr(),
                source.len(),
            )
        };
        if result.status != STATUS_OK {
            let msg = if result.error_message.is_null() {
                "plugin returned non-OK status".to_string()
            } else {
                unsafe { CStr::from_ptr(result.error_message) }
                    .to_string_lossy()
                    .into_owned()
            };
            unsafe { (plugin.free)(result) };
            return Err(anyhow!("{}: {msg}", target.entry.name));
        }
        let parsed: ExtractionOutput = if result.json_data.is_null() || result.json_len == 0 {
            ExtractionOutput::default()
        } else {
            let slice = unsafe { std::slice::from_raw_parts(result.json_data, result.json_len) };
            serde_json::from_slice(slice).context("parse plugin JSON output")?
        };
        unsafe { (plugin.free)(result) };
        Ok(parsed)
    }

    fn load_or_get(&self, target: &EntryWithDir) -> Result<Arc<LoadedPlugin>> {
        let mut cache = self.inner.loaded.lock().expect("plugin cache lock");
        if let Some(p) = cache.get(&target.entry.file) {
            return Ok(p.clone());
        }
        let plugin = open_and_verify(&target.dir, &target.entry)?;
        let arc = Arc::new(plugin);
        cache.insert(target.entry.file.clone(), arc.clone());
        Ok(arc)
    }
}

fn default_search_paths() -> Vec<PathBuf> {
    let mut dirs: Vec<PathBuf> = Vec::new();
    if let Ok(env) = std::env::var("GRAPHY_PLUGIN_PATH") {
        for part in env.split(':').filter(|s| !s.is_empty()) {
            dirs.push(PathBuf::from(part));
        }
    }
    if let Some(data) = dirs::data_dir() {
        dirs.push(data.join("graphy").join("plugins"));
    }
    dirs.push(PathBuf::from("graphy-plugins"));
    if let Ok(exe) = std::env::current_exe()
        && let Some(parent) = exe.parent()
    {
        dirs.push(parent.join("plugins"));
    }
    dirs
}

fn open_and_verify(dir: &Path, entry: &PluginEntry) -> Result<LoadedPlugin> {
    let path = dir.join(&entry.file);
    let actual = sha256_of(&path).with_context(|| format!("hash {}", path.display()))?;
    if actual != entry.sha256.to_ascii_lowercase() {
        return Err(anyhow!(
            "sha256 mismatch for {}: manifest={} actual={}",
            entry.file,
            entry.sha256,
            actual
        ));
    }
    let lib =
        unsafe { Library::new(&path) }.with_context(|| format!("dlopen {}", path.display()))?;
    let version_fn: Symbol<AbiVersionFn> = unsafe { lib.get(b"graphy_plugin_abi_version") }
        .context("missing graphy_plugin_abi_version")?;
    let v = unsafe { version_fn() };
    if v != ABI_VERSION {
        return Err(anyhow!(
            "plugin ABI mismatch: plugin={v} host={ABI_VERSION}"
        ));
    }
    let extract_sym: Symbol<ExtractFn> =
        unsafe { lib.get(b"graphy_plugin_extract") }.context("missing graphy_plugin_extract")?;
    let free_sym: Symbol<FreeFn> =
        unsafe { lib.get(b"graphy_plugin_free") }.context("missing graphy_plugin_free")?;
    let extract = *extract_sym;
    let free = *free_sym;
    Ok(LoadedPlugin {
        _library: lib,
        extract,
        free,
    })
}
