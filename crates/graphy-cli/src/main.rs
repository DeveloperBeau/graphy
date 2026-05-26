//! `graphy` CLI: build a knowledge graph from any folder of source.

use std::path::PathBuf;

use anyhow::Result;
use clap::{Parser, Subcommand};
use graphy_core::{Pipeline, PipelineConfig};
use tracing_subscriber::EnvFilter;

#[derive(Parser, Debug)]
#[command(
    name = "graphy",
    version,
    about = "Turn a folder of code into a queryable knowledge graph."
)]
struct Cli {
    #[command(subcommand)]
    command: Option<Command>,

    /// Path to scan (default: .). Used when no subcommand is given.
    path: Option<PathBuf>,

    /// Include doc files (md/mdx/rst/...).
    #[arg(long)]
    docs: bool,

    /// Output root (default: same as input).
    #[arg(long)]
    out: Option<PathBuf>,

    /// Disable entity deduplication.
    #[arg(long)]
    no_dedup: bool,

    /// Force a full rebuild even when a prior graph exists.
    #[arg(long)]
    full: bool,

    /// Disable SCC expansion for delta-Louvain (cycle-aware clustering).
    #[arg(long)]
    no_scc_expansion: bool,

    /// Disable hierarchical Louvain level caching (use single-pass clustering).
    #[arg(long)]
    no_hierarchical: bool,
}

#[derive(Subcommand, Debug)]
enum Command {
    /// Run the full pipeline on PATH (default).
    Run {
        path: PathBuf,
        #[arg(long)]
        docs: bool,
        #[arg(long)]
        out: Option<PathBuf>,
        /// Disable entity deduplication.
        #[arg(long)]
        no_dedup: bool,
        /// Force a full rebuild even when a prior graph exists.
        #[arg(long)]
        full: bool,
        /// Disable SCC expansion for delta-Louvain (cycle-aware clustering).
        #[arg(long)]
        no_scc_expansion: bool,
        /// Disable hierarchical Louvain level caching (use single-pass clustering).
        #[arg(long)]
        no_hierarchical: bool,
    },
    /// Re-run the pipeline whenever a file under PATH changes.
    Watch {
        path: PathBuf,
        #[arg(long)]
        docs: bool,
        #[arg(long)]
        out: Option<PathBuf>,
    },
    /// Run an MCP-style JSON-RPC server over stdio against GRAPH_JSON.
    Serve {
        /// Path to graph.json. Defaults to ./graphy-out/graph.json.
        #[arg(long, value_name = "GRAPH_JSON")]
        graph: Option<PathBuf>,
    },
    /// Plugin management subcommands.
    Plugins {
        #[command(subcommand)]
        action: PluginsAction,
    },
    /// Print version + build info.
    Doctor,
}

#[derive(Subcommand, Debug)]
enum PluginsAction {
    /// Show every plugin registered through manifest discovery.
    List,
    /// Re-scan a plugin directory and write a fresh manifest.toml.
    RegenerateManifest {
        /// Directory containing plugin dylibs (defaults to <exe-dir>/plugins).
        dir: Option<PathBuf>,
    },
    /// Copy a built plugin dylib into the user's plugin directory and
    /// regenerate the manifest.
    Install {
        /// Source dylib to install.
        source: PathBuf,
        /// Destination plugin directory (defaults to XDG data dir / graphy / plugins).
        #[arg(long)]
        dest: Option<PathBuf>,
    },
}

fn main() -> Result<()> {
    tracing_subscriber::fmt()
        .with_env_filter(
            EnvFilter::try_from_default_env().unwrap_or_else(|_| EnvFilter::new("info")),
        )
        .with_target(false)
        .compact()
        .init();

    let cli = Cli::parse();
    match cli.command {
        Some(Command::Doctor) => {
            println!("graphy {}", env!("CARGO_PKG_VERSION"));
            println!("rust target: {}", std::env::consts::ARCH);
            Ok(())
        }
        Some(Command::Run {
            path,
            docs,
            out,
            no_dedup,
            full,
            no_scc_expansion,
            no_hierarchical,
        }) => run(
            path,
            docs,
            out,
            no_dedup,
            full,
            no_scc_expansion,
            no_hierarchical,
        ),
        Some(Command::Watch { path, docs, out }) => watch(path, docs, out),
        Some(Command::Serve { graph }) => {
            let graph = graph.unwrap_or_else(|| PathBuf::from("graphy-out").join("graph.json"));
            graphy_core::serve::serve(&graph)
        }
        Some(Command::Plugins { action }) => plugins_cmd(action),
        None => {
            let path = cli.path.unwrap_or_else(|| PathBuf::from("."));
            run(
                path,
                cli.docs,
                cli.out,
                cli.no_dedup,
                cli.full,
                cli.no_scc_expansion,
                cli.no_hierarchical,
            )
        }
    }
}

fn plugins_cmd(action: PluginsAction) -> Result<()> {
    match action {
        PluginsAction::List => {
            let reg = graphy_core::loader::PluginRegistry::load_from_default_paths()?;
            if reg.is_empty() {
                println!("no plugins registered");
                return Ok(());
            }
            println!("{:<28} {:<10} EXTENSIONS", "PLUGIN", "VERSION");
            for entry in reg.entries() {
                println!(
                    "{:<28} {:<10} {}",
                    entry.name,
                    entry.version,
                    entry.extensions.join(", "),
                );
            }
            Ok(())
        }
        PluginsAction::RegenerateManifest { dir } => {
            let dir = dir.unwrap_or_else(default_plugin_dir);
            let manifest = graphy_core::manifest::build_from_directory(&dir)?;
            let written = manifest.write(&dir)?;
            println!(
                "wrote {} ({} plugins)",
                written.display(),
                manifest.plugins.len()
            );
            Ok(())
        }
        PluginsAction::Install { source, dest } => {
            let dest = dest.unwrap_or_else(default_plugin_dir);
            std::fs::create_dir_all(&dest)?;
            let file_name = source
                .file_name()
                .ok_or_else(|| anyhow::anyhow!("source has no file name"))?;
            let target = dest.join(file_name);
            std::fs::copy(&source, &target)?;
            let manifest = graphy_core::manifest::build_from_directory(&dest)?;
            manifest.write(&dest)?;
            println!(
                "installed {} → {} ({} plugins now registered)",
                source.display(),
                target.display(),
                manifest.plugins.len()
            );
            Ok(())
        }
    }
}

fn default_plugin_dir() -> PathBuf {
    if let Some(data) = dirs::data_dir() {
        return data.join("graphy").join("plugins");
    }
    PathBuf::from(".").join("graphy-plugins")
}

fn make_cfg(path: PathBuf, docs: bool, out: Option<PathBuf>) -> PipelineConfig {
    let mut cfg = PipelineConfig::new(path);
    cfg.include_docs = docs;
    if let Some(o) = out {
        cfg.out_root = o;
    }
    cfg
}

fn watch(path: PathBuf, docs: bool, out: Option<PathBuf>) -> Result<()> {
    graphy_core::watch::watch(make_cfg(path, docs, out))
}

fn run(
    path: PathBuf,
    docs: bool,
    out: Option<PathBuf>,
    no_dedup: bool,
    full: bool,
    no_scc_expansion: bool,
    no_hierarchical: bool,
) -> Result<()> {
    let mut cfg = make_cfg(path, docs, out);
    cfg.dedup = !no_dedup;
    cfg.incremental = !full;
    cfg.scc_expansion = !no_scc_expansion;
    cfg.hierarchical_clustering = !no_hierarchical;
    let result = Pipeline::new(cfg).run()?;
    println!(
        "scanned {} files ({} from cache) in {} ms → {} nodes, {} edges, {} communities",
        result.files_scanned,
        result.files_cached,
        result.elapsed_ms,
        result.analysis.node_count,
        result.analysis.edge_count,
        result.analysis.community_count,
    );
    println!("  graph:  {}", result.paths.graph_json.display());
    println!("  report: {}", result.paths.report_md.display());
    println!("  html:   {}", result.paths.graph_html.display());
    Ok(())
}
