//! `extract::js_ts`: JavaScript / TypeScript / TSX flavors via tree-sitter.

use std::fs;

use graphy_core::extract::extract;
use tempfile::tempdir;

fn ext(suffix: &str, src: &str) -> graphy_core::schema::ExtractionOutput {
    let dir = tempdir().unwrap();
    let p = dir.path().join(format!("x{suffix}"));
    fs::write(&p, src).unwrap();
    let r = extract(&p).unwrap();
    std::mem::forget(dir);
    r
}

#[test]
fn js_extracts_classes_and_imports() {
    let out = ext(".js", "import { x } from 'm';\nclass C { f(){} }\n");
    assert!(out.nodes.iter().any(|n| n.label == "C"));
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn ts_extracts_interfaces() {
    let out = ext(".ts", "export interface User { id: number }\n");
    assert!(out.nodes.iter().any(|n| n.label == "User"));
}

#[test]
fn ts_extracts_classes_and_methods() {
    let out = ext(".ts", "export class Svc { run(){} other(){} }");
    assert!(out.nodes.iter().any(|n| n.label == "Svc"));
    assert!(out.nodes.iter().any(|n| n.label == "run"));
    assert!(out.nodes.iter().any(|n| n.label == "other"));
}

#[test]
fn tsx_parses_jsx() {
    let out = ext(
        ".tsx",
        "export const Btn = () => <button onClick={() => doIt()}>x</button>;\nfunction doIt(){}\n",
    );
    assert!(out.nodes.iter().any(|n| n.label == "doIt"));
}

#[test]
fn unsupported_extension_returns_empty() {
    let out = ext(".unknown_ext_xyz", "anything");
    assert!(out.nodes.is_empty());
}

#[test]
fn malformed_ts_does_not_panic() {
    let _ = ext(".ts", "import { } from\nclass {\n");
}

#[test]
fn js_extracts_arrow_function_calls() {
    let out = ext(
        ".js",
        "function bare(){}\nconst go = () => { bare(); bare(); };\ngo();\n",
    );
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(!calls.is_empty());
}

#[test]
fn ts_extracts_enum_and_type_alias() {
    let out = ext(".ts", "export enum Color { Red, Blue }\nexport type Id = number;\n");
    assert!(out.nodes.iter().any(|n| n.label == "Color"));
    assert!(out.nodes.iter().any(|n| n.label == "Id"));
}

#[test]
fn huge_ts_file_handled() {
    let mut body = String::new();
    for i in 0..2000 { body.push_str(&format!("export function f{i}(): void {{ }}\n")); }
    let out = ext(".ts", &body);
    assert!(out.nodes.len() >= 2000);
}
