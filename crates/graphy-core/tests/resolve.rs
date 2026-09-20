//! Unit tests for the project-wide call resolution pass (`crate::resolve`).

use graphy_core::resolve::{CallIndex, ResolveStats, UNRESOLVED_CALL, UNRESOLVED_PREFIX};
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

fn node(id: &str, label: &str, kind: &str, file: &str) -> Node {
    Node {
        id: id.to_string(),
        label: label.to_string(),
        source_file: Some(file.to_string()),
        source_location: None,
        kind: Some(kind.to_string()),
        signature: None,
    }
}

/// An unresolved-call sentinel edge. Confidence is deliberately `Ambiguous`
/// (not the `Confidence::default()` of `Inferred`) so a test that asserts
/// `Inferred` afterward proves the implementation actually touched the
/// field, rather than the input and the assertion sharing one untouched
/// default.
fn unresolved(caller: &str, callee: &str) -> Edge {
    Edge {
        source: caller.to_string(),
        target: format!("{UNRESOLVED_PREFIX}{callee}"),
        relation: UNRESOLVED_CALL.to_string(),
        confidence: Confidence::Ambiguous,
        attr: None,
    }
}

fn out(nodes: Vec<Node>, edges: Vec<Edge>) -> ExtractionOutput {
    ExtractionOutput { nodes, edges }
}

// ---------- Success cases ----------

#[test]
fn bare_name_resolves_to_the_unique_definition() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );

    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);

    assert_eq!(service.edges.len(), 1);
    let e = &service.edges[0];
    assert_eq!(e.relation, "calls");
    assert_eq!(e.target, "helpers.rs::format_name");
    assert_eq!(e.confidence, Confidence::Inferred);
    assert_eq!(
        stats,
        ResolveStats {
            resolved: 1,
            dropped: 0
        }
    );
}

#[test]
fn qualified_call_resolves_through_a_unique_head_in_the_same_file() {
    let helpers = out(
        vec![
            node("helpers.cs::Helpers", "Helpers", "class", "helpers.cs"),
            node(
                "helpers.cs::FormatName",
                "FormatName",
                "method",
                "helpers.cs",
            ),
        ],
        vec![],
    );
    let mut service = out(
        vec![node("Service.cs::Run", "Run", "method", "Service.cs")],
        vec![unresolved("Service.cs::Run", "Helpers.FormatName")],
    );

    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);

    assert_eq!(service.edges.len(), 1);
    assert_eq!(service.edges[0].target, "helpers.cs::FormatName");
    assert_eq!(service.edges[0].relation, "calls");
    assert_eq!(stats.resolved, 1);
    assert_eq!(stats.dropped, 0);
}

#[test]
fn resolution_is_idempotent() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );

    let index = CallIndex::build([&helpers, &service]);
    let _ = index.resolve_in(&mut service);
    let before: Vec<(String, String, String)> = service
        .edges
        .iter()
        .map(|e| (e.source.clone(), e.target.clone(), e.relation.clone()))
        .collect();
    let second = index.resolve_in(&mut service);
    let after: Vec<(String, String, String)> = service
        .edges
        .iter()
        .map(|e| (e.source.clone(), e.target.clone(), e.relation.clone()))
        .collect();

    assert_eq!(second, ResolveStats::default());
    assert_eq!(after, before);
}

#[test]
fn stats_count_both_outcomes() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![
            unresolved("service.rs::run", "format_name"),
            unresolved("service.rs::run", "printf"),
        ],
    );

    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);

    assert_eq!(
        stats,
        ResolveStats {
            resolved: 1,
            dropped: 1
        }
    );
}

// ---------- Failure cases ----------

#[test]
fn ambiguous_bare_name_is_skipped_not_guessed() {
    let a = out(
        vec![node(
            "a/helpers.rs::format_name",
            "format_name",
            "function",
            "a/helpers.rs",
        )],
        vec![],
    );
    let b = out(
        vec![node(
            "b/helpers.rs::format_name",
            "format_name",
            "function",
            "b/helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );

    let index = CallIndex::build([&a, &b, &service]);
    let stats = index.resolve_in(&mut service);

    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
}

#[test]
fn unknown_callee_is_dropped() {
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "printf")],
    );

    let index = CallIndex::build([&service]);
    let stats = index.resolve_in(&mut service);

    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
    assert!(
        !service
            .edges
            .iter()
            .any(|e| e.target == "unresolved::printf")
    );
}

#[test]
fn non_code_kinds_are_never_candidates() {
    let noise = out(
        vec![
            node("a.json::format_name", "format_name", "json_key", "a.json"),
            node("a.yaml::format_name", "format_name", "yaml_key", "a.yaml"),
            node("a.md::format_name", "format_name", "heading", "a.md"),
        ],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );

    let index = CallIndex::build([&noise, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);

    // Add a real definition alongside the noise: the gate must exclude the
    // noise and not exclude the signal.
    let real = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service2 = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );
    let index2 = CallIndex::build([&noise, &real, &service2]);
    let stats2 = index2.resolve_in(&mut service2);
    assert_eq!(service2.edges.len(), 1);
    assert_eq!(service2.edges[0].target, "helpers.rs::format_name");
    assert_eq!(stats2.resolved, 1);
}

#[test]
fn extern_nodes_are_never_candidates() {
    let externs = out(
        vec![node(
            "extern::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );

    let index = CallIndex::build([&externs, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
}

#[test]
fn ambiguous_kind_suffix_still_counts_as_code() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function?ambiguous",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );
    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);
    assert_eq!(service.edges.len(), 1);
    assert_eq!(service.edges[0].target, "helpers.rs::format_name");
    assert_eq!(stats.resolved, 1);

    let noise = out(
        vec![node(
            "a.json::format_name",
            "format_name",
            "json_key?ambiguous",
            "a.json",
        )],
        vec![],
    );
    let mut service2 = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![unresolved("service.rs::run", "format_name")],
    );
    let index2 = CallIndex::build([&noise, &service2]);
    let stats2 = index2.resolve_in(&mut service2);
    assert!(service2.edges.is_empty());
    assert_eq!(stats2.dropped, 1);
}

#[test]
fn receiver_calls_are_skipped() {
    // Candidate nodes literally labelled `self`/`this`/`cls`/`super`, each
    // in the same file as `run`/`init`, make the receiver-keyword gate
    // observable: without it, the qualified-lookup path would find a
    // unique head candidate and successfully resolve the call, rather than
    // merely falling through a `by_label` miss that a keyword with no
    // matching node would produce regardless of the gate.
    let defs = out(
        vec![
            node("service.rs::run", "run", "function", "service.rs"),
            node("service.rs::init", "init", "function", "service.rs"),
            node("service.rs::self", "self", "class", "service.rs"),
            node("service.rs::this", "this", "class", "service.rs"),
            node("service.rs::cls", "cls", "class", "service.rs"),
            node("service.rs::super", "super", "class", "service.rs"),
        ],
        vec![],
    );
    let mut service = out(
        vec![node(
            "service.rs::caller",
            "caller",
            "function",
            "service.rs",
        )],
        vec![
            unresolved("service.rs::caller", "self.run"),
            unresolved("service.rs::caller", "this.run"),
            unresolved("service.rs::caller", "cls.run"),
            unresolved("service.rs::caller", "super.init"),
        ],
    );

    let index = CallIndex::build([&defs, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 4);
}

#[test]
fn qualified_call_with_an_ambiguous_head_is_skipped() {
    let a = out(
        vec![
            node("a/helpers.cs::Helpers", "Helpers", "class", "a/helpers.cs"),
            node(
                "a/helpers.cs::FormatName",
                "FormatName",
                "method",
                "a/helpers.cs",
            ),
        ],
        vec![],
    );
    let b = out(
        vec![node(
            "b/helpers.cs::Helpers",
            "Helpers",
            "class",
            "b/helpers.cs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("Service.cs::Run", "Run", "method", "Service.cs")],
        vec![unresolved("Service.cs::Run", "Helpers.FormatName")],
    );

    let index = CallIndex::build([&a, &b, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
}

#[test]
fn qualified_call_whose_leaf_lives_in_another_file_is_skipped() {
    let a = out(
        vec![node("a.cs::Helpers", "Helpers", "class", "a.cs")],
        vec![],
    );
    let b = out(
        vec![node("b.cs::FormatName", "FormatName", "method", "b.cs")],
        vec![],
    );
    let mut service = out(
        vec![node("Service.cs::Run", "Run", "method", "Service.cs")],
        vec![unresolved("Service.cs::Run", "Helpers.FormatName")],
    );

    let index = CallIndex::build([&a, &b, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
}

#[test]
fn non_identifier_callees_are_skipped() {
    let mut service = out(
        vec![node("service::run", "run", "function", "service")],
        vec![
            unresolved("service::run", "|>"),
            unresolved("service::run", "+"),
            unresolved("service::run", "2legit"),
            unresolved("service::run", ""),
            unresolved("service::run", "  "),
        ],
    );

    let index = CallIndex::build([&service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 5);
}

#[test]
fn an_existing_identical_call_edge_suppresses_the_duplicate() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![
            Edge {
                source: "service.rs::run".to_string(),
                target: "helpers.rs::format_name".to_string(),
                relation: "calls".to_string(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            unresolved("service.rs::run", "format_name"),
        ],
    );

    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);
    assert_eq!(service.edges.len(), 1);
    assert_eq!(stats.dropped, 1);
    assert_eq!(stats.resolved, 0);
}

#[test]
fn two_identical_sentinels_produce_one_edge() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        vec![
            unresolved("service.rs::run", "format_name"),
            unresolved("service.rs::run", "format_name"),
        ],
    );

    let index = CallIndex::build([&helpers, &service]);
    let stats = index.resolve_in(&mut service);
    assert_eq!(service.edges.len(), 1);
    assert_eq!(stats.resolved, 1);
    assert_eq!(stats.dropped, 1);
}

#[test]
fn a_definition_in_a_test_file_is_not_used_for_a_non_test_caller() {
    let defs = out(
        vec![
            node(
                "src/helpers.rs::make_flow",
                "make_flow",
                "function",
                "src/helpers.rs",
            ),
            node(
                "tests/support/mocks.rs::make_flow",
                "make_flow",
                "function",
                "tests/support/mocks.rs",
            ),
        ],
        vec![],
    );

    let mut non_test_caller = out(
        vec![node(
            "src/service.rs::run",
            "run",
            "function",
            "src/service.rs",
        )],
        vec![unresolved("src/service.rs::run", "make_flow")],
    );
    let index1 = CallIndex::build([&defs, &non_test_caller]);
    let stats1 = index1.resolve_in(&mut non_test_caller);
    assert_eq!(non_test_caller.edges.len(), 1);
    assert_eq!(non_test_caller.edges[0].target, "src/helpers.rs::make_flow");
    assert_eq!(stats1.resolved, 1);

    let mut test_caller = out(
        vec![node("tests/it.rs::case", "case", "function", "tests/it.rs")],
        vec![unresolved("tests/it.rs::case", "make_flow")],
    );
    let index2 = CallIndex::build([&defs, &test_caller]);
    let stats2 = index2.resolve_in(&mut test_caller);
    assert!(test_caller.edges.is_empty());
    assert_eq!(stats2.dropped, 1);
}

#[test]
fn only_test_candidates_and_a_non_test_caller_resolves_nothing() {
    let defs = out(
        vec![node(
            "tests/support/mocks.rs::make_flow",
            "make_flow",
            "function",
            "tests/support/mocks.rs",
        )],
        vec![],
    );
    let mut service = out(
        vec![node(
            "src/service.rs::run",
            "run",
            "function",
            "src/service.rs",
        )],
        vec![unresolved("src/service.rs::run", "make_flow")],
    );

    let index = CallIndex::build([&defs, &service]);
    let stats = index.resolve_in(&mut service);
    assert!(service.edges.is_empty());
    assert_eq!(stats.dropped, 1);
}

#[test]
fn no_unresolved_relation_survives() {
    let helpers = out(
        vec![node(
            "helpers.rs::format_name",
            "format_name",
            "function",
            "helpers.rs",
        )],
        vec![],
    );
    let mut edges = Vec::new();
    for i in 0..10 {
        let callee = if i % 2 == 0 { "format_name" } else { "printf" };
        edges.push(unresolved("service.rs::run", callee));
    }
    let mut service = out(
        vec![node("service.rs::run", "run", "function", "service.rs")],
        edges,
    );

    let index = CallIndex::build([&helpers, &service]);
    let _ = index.resolve_in(&mut service);
    assert!(service.edges.iter().all(|e| e.relation != UNRESOLVED_CALL));
}

#[test]
fn non_call_edges_are_untouched() {
    let mut service = out(
        vec![node(
            "service.rs::Service",
            "Service",
            "struct",
            "service.rs",
        )],
        vec![
            Edge {
                source: "service.rs".to_string(),
                target: "service.rs::Service".to_string(),
                relation: "contains".to_string(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "service.rs".to_string(),
                target: "extern::std".to_string(),
                relation: "imports".to_string(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "service.rs::Service".to_string(),
                target: "service.rs::name".to_string(),
                relation: "has_param".to_string(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "service.rs::Service".to_string(),
                target: "extern::Base".to_string(),
                relation: "inherits".to_string(),
                confidence: Confidence::Inferred,
                attr: None,
            },
        ],
    );
    let before = service.edges.clone();

    let index = CallIndex::build([&service]);
    let _ = index.resolve_in(&mut service);

    assert_eq!(service.edges.len(), before.len());
    for (a, b) in service.edges.iter().zip(before.iter()) {
        assert_eq!(a.source, b.source);
        assert_eq!(a.target, b.target);
        assert_eq!(a.relation, b.relation);
        assert_eq!(a.confidence, b.confidence);
    }
}

// ---------- Fuzz ----------

struct Xorshift64(u64);
impl Xorshift64 {
    fn next_u64(&mut self) -> u64 {
        let mut x = self.0;
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        self.0 = x;
        x
    }
    fn pick<'a, T>(&mut self, xs: &'a [T]) -> &'a T {
        &xs[(self.next_u64() as usize) % xs.len()]
    }
    fn range(&mut self, lo: u64, hi_inclusive: u64) -> u64 {
        lo + self.next_u64() % (hi_inclusive - lo + 1)
    }
}

const FUZZ_LABELS: &[&str] = &["a", "b", "format_name", "run", "Helpers", "x_1"];
const FUZZ_KINDS: &[&str] = &[
    "function",
    "method",
    "class",
    "struct",
    "enum",
    "interface",
    "protocol",
    "trait",
    "record",
    "object",
    "module",
    "namespace",
    "macro",
    "sub",
    "subroutine",
    "mod",
    "package",
    "unit",
    "extension",
    "mixin",
    "json_key",
    "import",
    "extern",
    "",
];
const FUZZ_FILES: &[&str] = &["src/a.rs", "src/b.rs", "tests/c.rs"];
const FUZZ_CALLEES: &[&str] = &[
    "a",
    "b",
    "format_name",
    "run",
    "Helpers",
    "x_1",
    "a.b",
    "self.x",
    "Helpers.format_name",
    "",
    "|>",
    "a::b::c",
];

fn fuzz_case(rng: &mut Xorshift64) -> (ExtractionOutput, Vec<Edge>) {
    let n_nodes = rng.range(1, 8);
    let mut nodes = Vec::new();
    for i in 0..n_nodes {
        let label = *rng.pick(FUZZ_LABELS);
        let kind = *rng.pick(FUZZ_KINDS);
        let file = *rng.pick(FUZZ_FILES);
        nodes.push(node(&format!("{file}::{label}#{i}"), label, kind, file));
    }
    let n_sentinels = rng.range(1, 8);
    let mut edges = Vec::new();
    let caller_file = *rng.pick(FUZZ_FILES);
    for _ in 0..n_sentinels {
        let callee = *rng.pick(FUZZ_CALLEES);
        edges.push(unresolved(&format!("{caller_file}::caller"), callee));
    }
    (out(nodes, edges.clone()), edges)
}

#[test]
fn fuzz_resolution_never_invents_a_target() {
    let mut rng = Xorshift64(0x9E3779B97F4A7C15);
    for iter in 0..2000 {
        let (mut extraction, original_sentinels) = fuzz_case(&mut rng);
        let n_sentinels = original_sentinels.len();

        let known_ids: std::collections::HashSet<String> =
            extraction.nodes.iter().map(|n| n.id.clone()).collect();

        let index = CallIndex::build([&extraction]);
        let stats = index.resolve_in(&mut extraction);

        // Invariant A: every surviving edge's target is a known node id.
        for e in &extraction.edges {
            assert!(
                known_ids.contains(e.target.as_str()),
                "iteration {iter}: pass invented target {:?} not present in input nodes",
                e.target
            );
        }

        // Invariant B: no surviving edge carries the sentinel relation.
        assert!(
            extraction
                .edges
                .iter()
                .all(|e| e.relation != UNRESOLVED_CALL),
            "iteration {iter}: sentinel relation survived resolve_in"
        );

        // Invariant C: resolved + dropped == number of input sentinels.
        assert_eq!(
            stats.resolved + stats.dropped,
            n_sentinels,
            "iteration {iter}: stats do not account for every sentinel"
        );

        // Invariant D: determinism under input node-order permutation.
        let mut shuffled_nodes = extraction.nodes.clone();
        // Reverse is a cheap, deterministic permutation distinct from the
        // original order whenever there is more than one node.
        shuffled_nodes.reverse();
        let mut shuffled = ExtractionOutput {
            nodes: shuffled_nodes,
            edges: original_sentinels.clone(),
        };
        let shuffled_index = CallIndex::build([&shuffled]);
        shuffled_index.resolve_in(&mut shuffled);

        let mut a: Vec<(String, String)> = extraction
            .edges
            .iter()
            .map(|e| (e.source.clone(), e.target.clone()))
            .collect();
        let mut b: Vec<(String, String)> = shuffled
            .edges
            .iter()
            .map(|e| (e.source.clone(), e.target.clone()))
            .collect();
        a.sort();
        b.sort();
        assert_eq!(
            a, b,
            "iteration {iter}: node order changed the resolution outcome"
        );
    }
}
