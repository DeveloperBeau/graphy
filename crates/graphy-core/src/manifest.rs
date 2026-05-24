//! Plugin manifest schema + I/O.
//!
//! Each plugins directory contains a `manifest.toml` enumerating every
//! shipped plugin, its file name, advertised extensions, and a SHA-256 of
//! the dylib bytes. The host parses this manifest at startup (cheap text
//! decode) and defers the actual `dlopen` until a file with a registered
//! extension is first encountered.
//!
//! ```toml
//! abi_version = 1
//!
//! [[plugin]]
//! name = "graphy-plugin-rust"
//! version = "0.1.0"
//! file = "libgraphy_plugin_rust.dylib"
//! extensions = ["rs"]
//! sha256 = "abc123…"
//! ```

use std::fs;
use std::path::{Path, PathBuf};

use anyhow::{Context, Result};
use serde::{Deserialize, Serialize};
use tracing as _;

pub const MANIFEST_FILENAME: &str = "manifest.toml";

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Manifest {
    pub abi_version: u32,
    #[serde(default)]
    pub generated_at: Option<String>,
    #[serde(default, rename = "plugin")]
    pub plugins: Vec<PluginEntry>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginEntry {
    pub name: String,
    pub version: String,
    pub file: String,
    pub extensions: Vec<String>,
    pub sha256: String,
}

impl Manifest {
    pub fn load(dir: &Path) -> Result<Self> {
        let path = dir.join(MANIFEST_FILENAME);
        let text = fs::read_to_string(&path)
            .with_context(|| format!("read {}", path.display()))?;
        let m: Manifest =
            toml::from_str(&text).with_context(|| format!("parse {}", path.display()))?;
        Ok(m)
    }

    pub fn try_load(dir: &Path) -> Option<Self> {
        Self::load(dir).ok()
    }

    pub fn write(&self, dir: &Path) -> Result<PathBuf> {
        fs::create_dir_all(dir)
            .with_context(|| format!("mkdir {}", dir.display()))?;
        let path = dir.join(MANIFEST_FILENAME);
        let text = toml::to_string_pretty(self).context("serialize manifest")?;
        fs::write(&path, text)
            .with_context(|| format!("write {}", path.display()))?;
        Ok(path)
    }
}

/// SHA-256 of the given file's bytes, hex-encoded lowercase.
pub fn sha256_of(path: &Path) -> Result<String> {
    use sha2::{Digest, Sha256};
    let bytes = fs::read(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut h = Sha256::new();
    h.update(&bytes);
    Ok(hex::encode(h.finalize()))
}

/// Scan `dir` for plugin dylibs, briefly load each to read its metadata, and
/// build a [`Manifest`]. Does not persist; call `Manifest::write` to save.
pub fn build_from_directory(dir: &Path) -> Result<Manifest> {
    use core::ffi::CStr;
    use graphy_plugin_api::GraphyPluginMetadata;
    use libloading::{Library, Symbol};

    type AbiFn = unsafe extern "C" fn() -> u32;
    type MetaFn = unsafe extern "C" fn() -> *const GraphyPluginMetadata;

    let mut plugins: Vec<PluginEntry> = Vec::new();
    let entries = fs::read_dir(dir)
        .with_context(|| format!("read_dir {}", dir.display()))?;
    for ent in entries.flatten() {
        let path = ent.path();
        let Some(name) = path.file_name().and_then(|s| s.to_str()) else { continue };
        if !is_dylib(&path) || name == MANIFEST_FILENAME {
            continue;
        }
        let lib = match unsafe { Library::new(&path) } {
            Ok(l) => l,
            Err(e) => {
                tracing::warn!(path = %path.display(), error = %e, "dlopen failed");
                continue;
            }
        };
        let abi: Symbol<AbiFn> = match unsafe { lib.get(b"graphy_plugin_abi_version") } {
            Ok(s) => s,
            Err(e) => {
                tracing::warn!(path = %path.display(), error = %e, "missing abi_version; skipping");
                continue;
            }
        };
        let v = unsafe { abi() };
        if v != graphy_plugin_api::ABI_VERSION {
            tracing::warn!(
                path = %path.display(),
                plugin_abi = v,
                host_abi = graphy_plugin_api::ABI_VERSION,
                "ABI mismatch; skipping",
            );
            continue;
        }
        let metaf: Symbol<MetaFn> = match unsafe { lib.get(b"graphy_plugin_metadata") } {
            Ok(s) => s,
            Err(_) => continue,
        };
        let meta_ptr = unsafe { metaf() };
        if meta_ptr.is_null() {
            continue;
        }
        let m = unsafe { &*meta_ptr };
        let name_str = unsafe { CStr::from_ptr(m.name) }.to_string_lossy().into_owned();
        let version_str = unsafe { CStr::from_ptr(m.version) }.to_string_lossy().into_owned();
        let mut extensions = Vec::new();
        if !m.extensions.is_null() && m.extension_count > 0 {
            let slice = unsafe { std::slice::from_raw_parts(m.extensions, m.extension_count) };
            for &p in slice {
                if p.is_null() { continue; }
                let s = unsafe { CStr::from_ptr(p) }.to_string_lossy().into_owned();
                if !s.is_empty() {
                    extensions.push(s.to_ascii_lowercase());
                }
            }
        }
        // Drop the library so the file is closed before we hash it (matters
        // on some platforms with file locks).
        drop(metaf);
        drop(abi);
        drop(lib);
        let sha = sha256_of(&path)?;
        plugins.push(PluginEntry {
            name: name_str,
            version: version_str,
            file: name.to_string(),
            extensions,
            sha256: sha,
        });
    }
    plugins.sort_by(|a, b| a.name.cmp(&b.name));
    Ok(Manifest {
        abi_version: graphy_plugin_api::ABI_VERSION,
        generated_at: Some(current_timestamp()),
        plugins,
    })
}

fn current_timestamp() -> String {
    use std::time::{SystemTime, UNIX_EPOCH};
    let secs = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .map(|d| d.as_secs())
        .unwrap_or(0);
    format!("epoch:{secs}")
}

fn is_dylib(p: &Path) -> bool {
    p.extension()
        .and_then(|s| s.to_str())
        .map(|e| matches!(e, "dylib" | "so" | "dll"))
        .unwrap_or(false)
}
