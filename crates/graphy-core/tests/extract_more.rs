//! Tests for the six additional language extractors: Java, C, C++, Ruby, C#,
//! Bash, and JSON. Each extractor gets a happy-path test plus an edge-case
//! test (empty, malformed) to ensure robustness.

use std::fs;
use std::path::{Path, PathBuf};

use graphy_core::extract::extract;
use tempfile::TempDir;

fn write(dir: &Path, name: &str, body: &str) -> PathBuf {
    let p = dir.join(name);
    fs::write(&p, body).unwrap();
    p
}

fn run(suffix: &str, src: &str) -> graphy_core::schema::ExtractionOutput {
    let dir = TempDir::new().unwrap();
    let p = write(dir.path(), &format!("file{suffix}"), src);
    let out = extract(&p).unwrap();
    std::mem::forget(dir);
    out
}

// ---------- Java ----------

#[test]
fn java_extracts_class_method_and_import() {
    let out = run(
        ".java",
        "import java.util.List;\nclass Foo { void bar() {} void baz() { bar(); } }",
    );
    assert!(out.nodes.iter().any(|n| n.label == "Foo"));
    assert!(out.nodes.iter().any(|n| n.label == "bar"));
    assert!(out.nodes.iter().any(|n| n.label == "baz"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn java_empty_file_safe() {
    let out = run(".java", "");
    assert!(out.nodes.is_empty());
}

#[test]
fn java_malformed_does_not_panic() {
    let _ = run(".java", "class { void ( }");
}

// ---------- C ----------

#[test]
fn c_extracts_function_and_include() {
    let out = run(
        ".c",
        "#include <stdio.h>\nint helper() { return 1; }\nint main() { helper(); return 0; }",
    );
    assert!(out.nodes.iter().any(|n| n.label == "helper"));
    assert!(out.nodes.iter().any(|n| n.label == "main"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn c_extracts_struct() {
    let out = run(".c", "struct Point { int x; int y; };");
    assert!(out.nodes.iter().any(|n| n.label == "Point"));
}

#[test]
fn c_empty_safe() {
    let out = run(".c", "");
    assert!(out.nodes.is_empty());
}

// ---------- C++ ----------

#[test]
fn cpp_extracts_class_and_method() {
    let out = run(
        ".cpp",
        "#include <vector>\nclass Svc { public: void run() {} void use() { run(); } };",
    );
    assert!(out.nodes.iter().any(|n| n.label == "Svc"));
    assert!(out.nodes.iter().any(|n| n.label == "run"));
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn cpp_extracts_header_include_with_quotes() {
    let out = run(".cpp", "#include \"local.h\"\nvoid f(){}\n");
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

// ---------- Ruby ----------

#[test]
fn ruby_extracts_class_method_and_require() {
    let out = run(
        ".rb",
        "require 'json'\nclass Svc\n  def run; helper; end\n  def helper; end\nend",
    );
    assert!(out.nodes.iter().any(|n| n.label == "Svc"));
    assert!(out.nodes.iter().any(|n| n.label == "run"));
    assert!(out.nodes.iter().any(|n| n.label == "helper"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn ruby_extracts_require_relative() {
    let out = run(".rb", "require_relative \"lib/util\"\ndef f; end");
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn ruby_empty_safe() {
    let out = run(".rb", "");
    assert!(out.nodes.is_empty());
}

// ---------- C# ----------

#[test]
fn csharp_extracts_class_method_and_using() {
    let out = run(
        ".cs",
        "using System;\nclass Svc { void Run() { Helper(); } void Helper() {} }",
    );
    assert!(out.nodes.iter().any(|n| n.label == "Svc"));
    assert!(out.nodes.iter().any(|n| n.label == "Run"));
    assert!(out.nodes.iter().any(|n| n.label == "Helper"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn csharp_extracts_record_and_interface() {
    let out = run(".cs", "interface IFoo {}\nrecord Bar(int x);");
    assert!(out.nodes.iter().any(|n| n.label == "IFoo"));
    assert!(out.nodes.iter().any(|n| n.label == "Bar"));
}

// ---------- Bash ----------

#[test]
fn bash_extracts_function_definition_and_source() {
    let out = run(".sh", "source ./lib.sh\nfn() { echo hi; }\nfn\n");
    assert!(out.nodes.iter().any(|n| n.label == "fn"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn bash_extracts_dot_source_alias() {
    let out = run(".bash", ". ./lib.sh\nfn(){ :; }\n");
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn bash_empty_safe() {
    let out = run(".sh", "");
    assert!(out.nodes.is_empty());
}

// ---------- JSON ----------

#[test]
fn json_extracts_top_level_keys_as_nodes() {
    let out = run(
        ".json",
        r#"{"name":"x","version":"1","scripts":{"build":"cc"}}"#,
    );
    assert!(out.nodes.iter().any(|n| n.label == "name"));
    assert!(out.nodes.iter().any(|n| n.label == "version"));
    assert!(out.nodes.iter().any(|n| n.label == "scripts"));
}

#[test]
fn json_extracts_ref_edges() {
    let out = run(
        ".json",
        r##"{"items":{"$ref":"#/components/schemas/Foo"}}"##,
    );
    assert!(out.edges.iter().any(|e| e.relation == "references"));
}

#[test]
fn json_empty_object_safe() {
    let out = run(".json", "{}");
    assert!(out.nodes.is_empty());
    assert!(out.edges.is_empty());
}

#[test]
fn json_malformed_does_not_panic() {
    let _ = run(".json", "{ not valid");
}
