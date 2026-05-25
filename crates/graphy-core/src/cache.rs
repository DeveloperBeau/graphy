//! Content-hash extraction cache.
//!
//! Layout under `<out_root>/graphy-out/.cache/`:
//!
//! ```text
//! .cache/
//! ├── manifest.json    { "path/to/foo.rs": "blake3:..." }
//! └── <blake3>.json    serialized ExtractionOutput
//! ```
//!
//! On each run we compute the hash for every file, look it up in the manifest
//! to find an existing per-file output, and skip tree-sitter work for hits.
//! New outputs are written back so the next run is incremental.

use std::collections::HashMap;
use std::fs;
use std::path::{Path, PathBuf};

use anyhow::{Context, Result};
use serde::{Deserialize, Serialize};

use crate::dedup::map::DedupMap;
use crate::schema::ExtractionOutput;

const CACHE_DIR: &str = ".cache";
const MANIFEST_FILE: &str = "manifest.json";

pub const CACHE_ABI: u32 = 2;

/// (cached outputs, files needing fresh extraction).
#[derive(Debug, Default)]
pub struct CachePartition {
    pub cached: Vec<(PathBuf, ExtractionOutput)>,
    pub uncached: Vec<PathBuf>,
}

#[derive(Debug, Default, Serialize, Deserialize)]
struct Manifest {
    #[serde(default = "default_abi_v1")]
    abi_version: u32,
    /// Map of relative-or-absolute path → content hash.
    entries: HashMap<String, String>,
}

fn default_abi_v1() -> u32 {
    1
}

#[derive(Debug)]
pub struct Cache {
    root: PathBuf,
    manifest: Manifest,
    /// Hashes computed during the current run, keyed by path. We carry them
    /// from `partition` to `save` so we don't recompute on store.
    pending: HashMap<PathBuf, String>,
}

impl Cache {
    /// Open (or create) the cache rooted at `<out_root>/graphy-out/.cache/`.
    pub fn open(out_root: &Path) -> Result<Self> {
        let root = out_root.join("graphy-out").join(CACHE_DIR);
        fs::create_dir_all(&root)
            .with_context(|| format!("mkdir {}", root.display()))?;
        let manifest_path = root.join(MANIFEST_FILE);
        let manifest = if manifest_path.exists() {
            let text = fs::read_to_string(&manifest_path)?;
            serde_json::from_str(&text).unwrap_or_default()
        } else {
            Manifest::default()
        };
        Ok(Self { root, manifest, pending: HashMap::new() })
    }

    /// Split a candidate file list into cache hits (with their stored
    /// extraction output) and misses that still need to be extracted.
    pub fn partition(&mut self, files: &[PathBuf]) -> CachePartition {
        let mut out = CachePartition::default();
        for file in files {
            let key = file.to_string_lossy().into_owned();
            let Ok(bytes) = fs::read(file) else {
                out.uncached.push(file.clone());
                continue;
            };
            let hash = blake3::hash(&bytes).to_hex().to_string();
            self.pending.insert(file.clone(), hash.clone());
            if let Some(prev) = self.manifest.entries.get(&key) {
                if prev == &hash {
                    if let Some(stored) = self.load_output(&hash) {
                        out.cached.push((file.clone(), stored));
                        continue;
                    }
                }
            }
            out.uncached.push(file.clone());
        }
        out
    }

    /// Persist an extraction output for `file`, using the hash captured during
    /// the most recent `partition` call.
    pub fn save(&mut self, file: &Path, output: &ExtractionOutput) -> Result<()> {
        let Some(hash) = self.pending.get(file).cloned() else {
            return Ok(());
        };
        let key = file.to_string_lossy().into_owned();
        let target = self.root.join(format!("{hash}.json"));
        if !target.exists() {
            let body = serde_json::to_vec(output)?;
            fs::write(&target, body)
                .with_context(|| format!("write {}", target.display()))?;
        }
        self.manifest.entries.insert(key, hash);
        Ok(())
    }

    /// Flush manifest to disk. Should be called at the end of every run.
    pub fn flush(&mut self) -> Result<()> {
        self.manifest.abi_version = CACHE_ABI;
        let path = self.root.join(MANIFEST_FILE);
        let body = serde_json::to_vec_pretty(&self.manifest)?;
        fs::write(&path, body)
            .with_context(|| format!("write {}", path.display()))?;
        Ok(())
    }

    /// Load the `DedupMap` associated with `file`, if one was previously saved.
    /// Returns `None` for v1 manifests (which predate dedup map storage).
    pub fn load_dedup_map(&self, file: &Path) -> Option<DedupMap> {
        if self.manifest.abi_version < 2 { return None; }
        let key = file.to_string_lossy().into_owned();
        let hash = self.manifest.entries.get(&key)?;
        let path = self.root.join(format!("{hash}.dedup.json"));
        let text = std::fs::read_to_string(path).ok()?;
        serde_json::from_str(&text).ok()
    }

    /// Persist a `DedupMap` for `file`. No-ops gracefully if the file is not
    /// yet recorded in the manifest (i.e. `save` has not been called for it).
    pub fn save_dedup_map(&self, file: &Path, map: &DedupMap) -> Result<()> {
        let key = file.to_string_lossy().into_owned();
        let Some(hash) = self.manifest.entries.get(&key) else { return Ok(()) };
        let path = self.root.join(format!("{hash}.dedup.json"));
        let body = serde_json::to_vec_pretty(map)
            .context("serialize dedup map")?;
        std::fs::write(&path, body)
            .with_context(|| format!("write {}", path.display()))?;
        Ok(())
    }

    fn load_output(&self, hash: &str) -> Option<ExtractionOutput> {
        let path = self.root.join(format!("{hash}.json"));
        let text = fs::read_to_string(path).ok()?;
        serde_json::from_str(&text).ok()
    }
}
