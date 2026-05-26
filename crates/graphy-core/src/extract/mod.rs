//! Per-language extractors. Dispatch by file suffix.

mod bash;
mod c_family;
pub mod common;
mod csharp;
mod css;
mod dart;
mod elixir;
mod erlang;
mod fortran;
mod go;
mod groovy;
mod haskell;
mod html;
mod java;
mod js_ts;
mod json;
mod julia;
mod kotlin;
mod lua;
mod markdown;
mod objc;
mod ocaml;
mod pascal;
mod perl;
mod php;
mod powershell;
mod python;
mod r;
mod ruby;
mod rust;
mod scala;
mod sql;
mod svelte;
mod swift;
mod toml;
mod verilog;
mod yaml;
mod zig;

use std::path::Path;

use anyhow::Result;
use rayon::prelude::*;

use crate::loader::PluginRegistry;
use crate::schema::ExtractionOutput;

/// Extract a single file. Plugin-registered languages win over the built-in
/// extractors. Returns empty output for unsupported suffixes.
pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    if let Some(result) = PluginRegistry::global().extract(path) {
        return result;
    }
    let Some(ext) = path.extension().and_then(|s| s.to_str()) else {
        return Ok(ExtractionOutput::default());
    };
    match ext.to_ascii_lowercase().as_str() {
        "rs" => rust::extract(path),
        "py" => python::extract(path),
        "go" => go::extract(path),
        "js" | "jsx" | "mjs" | "cjs" | "ejs" => js_ts::extract(path, js_ts::Flavor::Javascript),
        "ts" => js_ts::extract(path, js_ts::Flavor::Typescript),
        "tsx" => js_ts::extract(path, js_ts::Flavor::Tsx),
        "java" => java::extract(path),
        "c" => c_family::extract(path, c_family::Flavor::C),
        "h" => {
            // Peek at the file contents to distinguish ObjC headers from plain C headers.
            // ObjC headers use `@interface`, `@protocol`, or `@implementation`.
            let peek = std::fs::read_to_string(path).unwrap_or_default();
            if peek.contains("@interface") || peek.contains("@protocol") || peek.contains("@implementation") {
                objc::extract(path)
            } else {
                c_family::extract(path, c_family::Flavor::C)
            }
        }
        "cpp" | "cc" | "cxx" | "hpp" => c_family::extract(path, c_family::Flavor::Cpp),
        "rb" => ruby::extract(path),
        "cs" => csharp::extract(path),
        "sh" | "bash" => bash::extract(path),
        "json" => json::extract(path),
        "swift" => swift::extract(path),
        "kt" | "kts" => kotlin::extract(path),
        "php" => php::extract(path),
        "scala" | "sc" => scala::extract(path),
        "lua" | "luau" => lua::extract(path),
        "zig" => zig::extract(path),
        "ex" | "exs" => elixir::extract(path),
        "m" | "mm" => objc::extract(path),
        "jl" => julia::extract(path),
        "html" | "htm" => html::extract(path),
        "css" => css::extract(path),
        "groovy" | "gradle" => groovy::extract(path),
        "ps1" => powershell::extract(path),
        "v" | "sv" => verilog::extract(path),
        "f" | "f90" | "f95" | "f03" | "f08" | "for" => fortran::extract(path),
        "sql" => sql::extract(path),
        "r" => r::extract(path),
        "dart" => dart::extract(path),
        "svelte" => svelte::extract(path),
        "md" | "mdx" | "qmd" => markdown::extract(path),
        "yaml" | "yml" => yaml::extract(path),
        "pas" | "pp" | "dpr" | "dpk" | "lpr" | "inc" => pascal::extract(path),
        "pl" | "pm" | "t" => perl::extract(path),
        "hs" => haskell::extract(path),
        "ml" | "mli" => ocaml::extract(path),
        "erl" | "hrl" => erlang::extract(path),
        "toml" => toml::extract(path),
        _ => Ok(ExtractionOutput::default()),
    }
}

/// Parallel extraction over a slice of paths.
pub fn extract_all(paths: &[std::path::PathBuf]) -> Vec<ExtractionOutput> {
    paths
        .par_iter()
        .map(|p| extract(p).unwrap_or_default())
        .collect()
}
