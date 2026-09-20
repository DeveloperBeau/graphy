//! Extractors must record a call they cannot resolve inside one file as a
//! sentinel edge, not drop it silently. `crate::resolve::CallIndex` (step 5)
//! is what turns these into real `calls` edges or removes them; this file
//! only tests the extractor side of the contract.

use std::path::{Path, PathBuf};

use graphy_core::extract::extract;

fn fixture(rel: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage")
        .join(rel)
}

#[test]
fn unresolved_call_is_recorded_not_dropped() {
    let path = fixture("swift/Sources/Service.swift");
    let out = extract(&path).unwrap();
    assert!(
        out.edges.iter().any(|e| e.relation == "calls?unresolved"
            && e.target == "unresolved::formatName"
            && e.source.ends_with("Service.swift::run")),
        "no unresolved sentinel for formatName: {:#?}",
        out.edges
    );
}

#[test]
fn locally_resolved_call_emits_no_sentinel() {
    let path = fixture("swift/Sources/Service.swift");
    let out = extract(&path).unwrap();
    let sentinel_init_count = out
        .edges
        .iter()
        .filter(|e| e.relation == "calls?unresolved" && e.target.ends_with("::init"))
        .count();
    assert_eq!(
        sentinel_init_count, 0,
        "super.init resolves locally and must not also emit a sentinel"
    );
    assert!(
        out.edges
            .iter()
            .any(|e| e.relation == "calls" && e.target.ends_with("Service.swift::init")),
        "expected the pre-existing local self-edge to init to survive: {:#?}",
        out.edges
    );
}

#[test]
fn extern_routed_call_emits_no_sentinel() {
    let path = fixture("go/service.go");
    let out = extract(&path).unwrap();
    assert!(
        out.edges
            .iter()
            .any(|e| e.relation == "calls" && e.target == "extern::fmt.Println"),
        "expected fmt.Println to route through extern::: {:#?}",
        out.edges
    );
    assert!(
        !out.edges
            .iter()
            .any(|e| e.target == "unresolved::fmt.Println"),
        "fmt.Println already resolved through extern:: and must not also get a sentinel"
    );
}

#[test]
fn ruby_bare_identifier_does_not_record_an_unresolved_call() {
    let path = fixture("ruby/lib/service.rb");
    let out = extract(&path).unwrap();
    assert!(
        !out.edges.iter().any(|e| e.target == "unresolved::greeting"),
        "a bare local variable must never become a call candidate: {:#?}",
        out.edges
    );
    assert!(
        out.edges
            .iter()
            .any(|e| e.relation == "calls?unresolved" && e.target == "unresolved::format_name"),
        "the real call (Helpers.format_name, bare via the `call` arm) must still be recorded: {:#?}",
        out.edges
    );
}

#[test]
fn rust_unresolved_call_is_recorded() {
    let path = fixture("rust/src/service.rs");
    let out = extract(&path).unwrap();
    assert!(
        out.edges.iter().any(|e| e.relation == "calls?unresolved"
            && e.target == "unresolved::format_name"
            && e.source.ends_with("service.rs::run")),
        "no unresolved sentinel for format_name: {:#?}",
        out.edges
    );
}

#[test]
fn sentinel_edges_survive_a_cache_round_trip() {
    use graphy_core::schema::{Confidence, Edge, ExtractionOutput};

    let out = ExtractionOutput {
        nodes: vec![],
        edges: vec![Edge {
            source: "a.rs::run".to_string(),
            target: "unresolved::format_name".to_string(),
            relation: "calls?unresolved".to_string(),
            confidence: Confidence::Inferred,
            attr: None,
        }],
    };
    let json = serde_json::to_string(&out).unwrap();
    let back: ExtractionOutput = serde_json::from_str(&json).unwrap();
    assert_eq!(back.edges.len(), 1);
    assert_eq!(back.edges[0].relation, "calls?unresolved");
    assert_eq!(back.edges[0].target, "unresolved::format_name");
}
