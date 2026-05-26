//! graphy-core: detect → extract → build → cluster → analyze → report → export pipeline.
//!
//! Pipeline: [`detect`] → [`extract`] → [`build`] → [`cluster`] → [`analyze`]
//! → [`report`] → [`export`].

pub mod analyze;
pub mod build;
pub mod cache;
pub mod cluster;
pub mod dedup;
pub mod detect;
pub mod export;
pub mod extract;
pub mod graph;
pub mod incremental;
pub mod loader;
pub mod manifest;
pub mod pipeline;
pub mod report;
pub mod scc;
pub mod schema;
pub mod security;
pub mod serve;
pub mod validate;
pub mod watch;

pub use graph::KnowledgeGraph;
pub use pipeline::{Pipeline, PipelineConfig, PipelineOutputs};
pub use schema::{Confidence, Edge, ExtractionOutput, Node};
