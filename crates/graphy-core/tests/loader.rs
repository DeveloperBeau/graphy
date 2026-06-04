//! End-to-end test: build dylib plugins, generate manifest, lazy-load, dispatch.

use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

use graphy_core::loader::PluginRegistry;
use graphy_core::manifest::{Manifest, build_from_directory};
use tempfile::tempdir;

fn workspace_root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .ancestors()
        .nth(2)
        .unwrap()
        .to_path_buf()
}

fn dylib_name(crate_name: &str) -> String {
    let stem = crate_name.replace('-', "_");
    if cfg!(target_os = "macos") {
        format!("lib{stem}.dylib")
    } else if cfg!(target_os = "windows") {
        format!("{stem}.dll")
    } else {
        format!("lib{stem}.so")
    }
}

fn ensure_plugin(plugin: &str) -> PathBuf {
    let target_dir = workspace_root().join("target").join("debug");
    let dylib = target_dir.join(dylib_name(plugin));
    if !dylib.exists() {
        let status = Command::new("cargo")
            .args(["build", "-p", plugin])
            .current_dir(workspace_root())
            .status()
            .expect("invoke cargo");
        assert!(status.success(), "cargo build {plugin} failed");
    }
    assert!(
        dylib.exists(),
        "expected built dylib at {}",
        dylib.display()
    );
    dylib
}

fn stage(dir: &Path, plugins: &[&str]) {
    for plugin in plugins {
        let built = ensure_plugin(plugin);
        let dest = dir.join(built.file_name().unwrap());
        fs::copy(&built, &dest).unwrap();
    }
    let manifest = build_from_directory(dir).expect("build manifest");
    manifest.write(dir).expect("write manifest");
}

#[test]
fn registry_with_no_plugin_path_is_empty() {
    let reg = PluginRegistry::load_from(&[]).unwrap();
    assert!(reg.is_empty());
    assert_eq!(reg.plugin_count(), 0);
}

#[test]
fn registry_skips_directory_without_manifest() {
    let dir = tempdir().unwrap();
    let built = ensure_plugin("graphy-plugin-rust");
    fs::copy(&built, dir.path().join(built.file_name().unwrap())).unwrap();
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    assert!(reg.is_empty());
}

#[test]
fn loader_dispatches_rust_plugin_via_manifest() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    assert!(reg.extensions().contains(&"rs".to_string()));

    let src_dir = tempdir().unwrap();
    let rs = src_dir.path().join("a.rs");
    fs::write(&rs, "pub fn f(){}\npub fn g(){ f(); }\n").unwrap();
    let out = reg.extract(&rs).unwrap().unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "f"));
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn loader_dispatches_python_plugin() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-python"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    let src_dir = tempdir().unwrap();
    let py = src_dir.path().join("a.py");
    fs::write(&py, "def helper(): pass\ndef main(): helper()\n").unwrap();
    let out = reg.extract(&py).unwrap().unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "helper"));
}

#[test]
fn loader_dispatches_json_plugin() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-json"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    let src_dir = tempdir().unwrap();
    let j = src_dir.path().join("a.json");
    fs::write(&j, r#"{"name":"x","version":"1"}"#).unwrap();
    let out = reg.extract(&j).unwrap().unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "name"));
}

#[test]
fn loader_rejects_corrupted_dylib_via_sha_mismatch() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let dylib_path = dir.path().join(dylib_name("graphy-plugin-rust"));
    fs::write(&dylib_path, b"corrupted").unwrap();
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    let src_dir = tempdir().unwrap();
    let rs = src_dir.path().join("a.rs");
    fs::write(&rs, "fn f(){}\n").unwrap();
    let err = reg.extract(&rs).unwrap().unwrap_err();
    assert!(err.to_string().contains("sha256 mismatch"));
}

#[test]
fn loader_returns_none_for_unsupported_extension() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();
    let src_dir = tempdir().unwrap();
    let p = src_dir.path().join("a.unknown_xyz");
    fs::write(&p, "nope").unwrap();
    assert!(reg.extract(&p).is_none());
}

#[test]
fn cached_plugin_is_reused_across_extract_calls() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    for i in 0..5 {
        let p = src_dir.path().join(format!("a{i}.rs"));
        fs::write(&p, format!("pub fn f{i}(){{}}\n")).unwrap();
        let out = reg.extract(&p).unwrap().unwrap();
        assert!(!out.nodes.is_empty());
    }
}

#[test]
fn manifest_can_be_written_and_read_back() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let m = Manifest::load(dir.path()).expect("manifest exists");
    assert_eq!(m.abi_version, graphy_plugin_api::ABI_VERSION);
    assert!(
        m.plugins
            .iter()
            .any(|p| p.name == "graphy-plugin-rust" && p.extensions.contains(&"rs".to_string()))
    );
}

#[test]
fn loader_dispatches_rust_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let rs = src_dir.path().join("a.rs");
    fs::write(
        &rs,
        "pub struct Widget { pub label: String }\n\
         pub fn build(widget: Widget) -> Widget { widget }\n",
    )
    .unwrap();
    let out = reg.extract(&rs).unwrap().unwrap();

    // The has_param edge and its attr survive the FFI + loader round-trip.
    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(
        hp.attr.as_ref().and_then(|a| a.name.as_deref()),
        Some("widget")
    );

    // The signature payload survives onto the schema node.
    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_go_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-go"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let go = src_dir.path().join("a.go");
    fs::write(
        &go,
        "package p\n\
         type Widget struct { W Widget }\n\
         func Build(w Widget) Widget { return w }\n",
    )
    .unwrap();
    let out = reg.extract(&go).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "Build")
        .expect("Build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_kotlin_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-kotlin"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let kt = src_dir.path().join("a.kt");
    fs::write(
        &kt,
        "data class Widget(val label: String)\n\
         fun build(widget: Widget): Widget { return widget }\n",
    )
    .unwrap();
    let out = reg.extract(&kt).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(
        hp.attr.as_ref().and_then(|a| a.name.as_deref()),
        Some("widget")
    );

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_scala_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-scala"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let scala = src_dir.path().join("a.scala");
    fs::write(
        &scala,
        "package p\n\
         class Widget(val inner: Widget)\n\
         def build(w: Widget): Widget = w\n",
    )
    .unwrap();
    let out = reg.extract(&scala).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_csharp_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-csharp"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let cs = src_dir.path().join("a.cs");
    fs::write(
        &cs,
        "public class Widget { public Widget Inner { get; set; } }\n\
         public class Svc { public Widget Build(Widget w) { return w; } }\n",
    )
    .unwrap();
    let out = reg.extract(&cs).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "Build")
        .expect("Build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_typescript_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-js-ts"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let ts = src_dir.path().join("a.ts");
    fs::write(
        &ts,
        "class Widget { label: string; owner: Person; }\n\
         class Person { name: string; }\n\
         function build(n: number, pet: Widget): Widget { return pet; }\n",
    )
    .unwrap();
    let out = reg.extract(&ts).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(
        hp.attr.as_ref().and_then(|a| a.name.as_deref()),
        Some("pet")
    );
    assert_eq!(hp.attr.as_ref().and_then(|a| a.index), Some(1));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_swift_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-swift"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let swift = src_dir.path().join("a.swift");
    fs::write(
        &swift,
        "struct Widget { var w: Widget }\n\
         func build(widget: Widget) -> Widget { return widget }\n\
         func collect(items: [Widget]) {}\n",
    )
    .unwrap();
    let out = reg.extract(&swift).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param" && e.source.ends_with("::build"))
        .expect("has_param edge");
    assert_eq!(
        hp.attr.as_ref().and_then(|a| a.name.as_deref()),
        Some("widget")
    );

    // Generic inner: sugar array `[Widget]` emits an edge to the inner Widget.
    let collect_hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param" && e.source.ends_with("::collect"))
        .expect("collect has_param edge");
    assert_eq!(collect_hp.target, "extern::Widget");
    assert_eq!(
        collect_hp.attr.as_ref().and_then(|a| a.name.as_deref()),
        Some("items")
    );

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_cpp_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-c-family"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    // struct before function to remove any type-vs-identifier parse ambiguity.
    let cpp = src_dir.path().join("a.cpp");
    fs::write(
        &cpp,
        "struct Widget { int x; };\nWidget build(Widget w, int n) { return w; }\n",
    )
    .unwrap();
    let out = reg.extract(&cpp).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_cpp_generic_param_resolves_to_inner_type() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-c-family"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let cpp = src_dir.path().join("a.cpp");
    // Class method removes type-vs-compare parse ambiguity for `<...>`.
    fs::write(
        &cpp,
        "struct Widget { int x; };\n\
         class Svc { public: void collect(std::vector<Widget> items) {} };\n",
    )
    .unwrap();
    let out = reg.extract(&cpp).unwrap().unwrap();

    // The std::vector container is suppressed; the has_param edge resolves to
    // the inner Widget. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::vector")
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "collect")
        .expect("collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("std::vector<Widget>")
    );
}

#[test]
fn loader_dispatches_java_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-java"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let java = src_dir.path().join("a.java");
    fs::write(
        &java,
        "public class Box { public Widget item; }\n\
         public class Builder { public Widget build(Widget w) { return w; } }\n",
    )
    .unwrap();
    let out = reg.extract(&java).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_ruby_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-ruby"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let rb = src_dir.path().join("a.rb");
    fs::write(
        &rb,
        "module Mailer\n  def self.deliver(recipient, subject)\n    recipient\n  end\nend\n\n\
         class Inbox\n  def archive(message)\n    message\n  end\nend\n",
    )
    .unwrap();
    let out = reg.extract(&rb).unwrap().unwrap();

    // NAME-ONLY: the signature payload carries parameter names with no type,
    // and the round-trip preserves it onto the schema node.
    let deliver = out
        .nodes
        .iter()
        .find(|n| n.label == "deliver")
        .expect("deliver node");
    let sig = deliver.signature.as_ref().expect("deliver signature");
    let names: Vec<&str> = sig.params.iter().map(|p| p.name.as_str()).collect();
    assert_eq!(names, vec!["recipient", "subject"]);
    assert!(sig.params.iter().all(|p| p.ty.is_none()));
    assert!(sig.returns.is_none());

    // NAME-ONLY: no typed edges and no kind:"type" nodes survive the round-trip.
    for rel in ["has_param", "returns", "has_field"] {
        assert!(
            !out.edges.iter().any(|e| e.relation == rel),
            "unexpected {rel} edge in NAME-ONLY round-trip"
        );
    }
    assert!(
        !out.nodes.iter().any(|n| n.kind.as_deref() == Some("type")),
        "unexpected kind:type node in NAME-ONLY round-trip"
    );
}

#[test]
fn loader_dispatches_python_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-python"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let py = src_dir.path().join("a.py");
    fs::write(
        &py,
        "class Widget:\n    pass\n\ndef build(w: Widget, untyped) -> Widget:\n    return w\n",
    )
    .unwrap();
    let out = reg.extract(&py).unwrap().unwrap();
    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));
    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(build.signature.as_ref().unwrap().params.len(), 2);
}
#[test]
fn loader_dispatches_php_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-php"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let php = src_dir.path().join("a.php");
    fs::write(
        &php,
        "<?php\n\
         class Box { public Widget $item; }\n\
         function build(Widget $w): Widget { return $w; }\n",
    )
    .unwrap();
    let out = reg.extract(&php).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("Widget")
    );
}

#[test]
fn loader_dispatches_lua_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-lua"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let lua = src_dir.path().join("a.lua");
    fs::write(
        &lua,
        "function M.new_state(name, opts)\n  return name\nend\n\
         function Service:run(mode)\n  return mode\nend\n",
    )
    .unwrap();
    let out = reg.extract(&lua).unwrap().unwrap();

    // Function-with-params carries parameter names, all with ty:None.
    let new_state = out
        .nodes
        .iter()
        .find(|n| n.label == "M.new_state")
        .expect("new_state node");
    let sig = new_state.signature.as_ref().expect("signature payload");
    let names: Vec<&str> = sig.params.iter().map(|p| p.name.as_str()).collect();
    assert_eq!(names, ["name", "opts"]);
    assert!(sig.params.iter().all(|p| p.ty.is_none()));
    assert!(sig.returns.is_none());
    assert!(sig.fields.is_empty());

    // Method-with-params likewise.
    let run = out
        .nodes
        .iter()
        .find(|n| n.label == "Service:run")
        .expect("run node");
    let run_names: Vec<&str> = run
        .signature
        .as_ref()
        .unwrap()
        .params
        .iter()
        .map(|p| p.name.as_str())
        .collect();
    assert_eq!(run_names, ["mode"]);

    // Name-only: no typed edges, no kind:"type" nodes.
    assert!(
        !out.edges
            .iter()
            .any(|e| matches!(e.relation.as_str(), "has_param" | "returns" | "has_field"))
    );
    assert!(!out.nodes.iter().any(|n| n.kind.as_deref() == Some("type")));
}

#[test]
fn loader_dispatches_sql_plugin_typed_signature_layer() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-sql"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let sql = src_dir.path().join("a.sql");
    fs::write(
        &sql,
        "CREATE FUNCTION build(w widget_type, n integer) RETURNS widget_type AS $$ SELECT w; $$ LANGUAGE sql;\n",
    )
    .unwrap();
    let out = reg.extract(&sql).unwrap().unwrap();
    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.attr.as_ref().and_then(|a| a.name.as_deref()), Some("w"));
    let build = out
        .nodes
        .iter()
        .find(|n| n.label == "build")
        .expect("build node");
    assert_eq!(
        build.signature.as_ref().and_then(|s| s.returns.as_deref()),
        Some("widget_type")
    );
}

#[test]
fn loader_rust_plugin_emits_generic_inner_types() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-rust"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let rs = src_dir.path().join("a.rs");
    fs::write(&rs, "pub fn g(items: Vec<Widget>) {}\n").unwrap();
    let out = reg.extract(&rs).unwrap().unwrap();

    let hp = out
        .edges
        .iter()
        .find(|e| e.relation == "has_param")
        .expect("has_param edge");
    assert_eq!(hp.target, "extern::Widget");
    assert!(!out.edges.iter().any(|e| e.target == "extern::Vec"));
}
#[test]
fn loader_scala_generic_param_resolves_to_inner_type() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-scala"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let scala = src_dir.path().join("a.scala");
    fs::write(
        &scala,
        "package p\n\
         class Widget\n\
         def collect(items: List[Widget]): Unit = ()\n",
    )
    .unwrap();
    let out = reg.extract(&scala).unwrap().unwrap();

    // The List container is suppressed; the has_param edge resolves to the
    // inner Widget. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::List")
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "collect")
        .expect("collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("List[Widget]")
    );
}

#[test]
fn loader_typescript_generic_param_resolves_to_inner_type() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-js-ts"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let ts = src_dir.path().join("a.ts");
    fs::write(
        &ts,
        "class Widget { label: string; }\n\
         function collect(items: Array<Widget>): void {}\n",
    )
    .unwrap();
    let out = reg.extract(&ts).unwrap().unwrap();

    // The Array container is suppressed; the has_param edge resolves to the
    // inner Widget. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::Array")
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "collect")
        .expect("collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("Array<Widget>")
    );
}

#[test]
fn loader_csharp_generic_param_resolves_to_inner_type() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-csharp"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let cs = src_dir.path().join("a.cs");
    fs::write(
        &cs,
        "public class Widget { public string Label { get; set; } }\n\
         public class Svc { public void Collect(List<Widget> items) {} }\n",
    )
    .unwrap();
    let out = reg.extract(&cs).unwrap().unwrap();

    // The List container is suppressed; the has_param edge resolves to the inner
    // Widget. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::List")
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "Collect")
        .expect("Collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("List<Widget>")
    );
}

#[test]
fn loader_go_generic_param_emits_container_and_inner() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-go"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let go = src_dir.path().join("a.go");
    fs::write(
        &go,
        "package p\n\
         func collect(b Box[Widget]) {}\n",
    )
    .unwrap();
    let out = reg.extract(&go).unwrap().unwrap();

    // Go generics have no stdlib named container, so the user base Box and the
    // inner Widget BOTH get has_param edges. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert!(
        hp.iter().any(|e| e.target == "extern::Box"),
        "missing container edge; edges = {:#?}",
        out.edges
    );
    assert!(
        hp.iter().any(|e| e.target == "extern::Widget"),
        "missing inner edge; edges = {:#?}",
        out.edges
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "collect")
        .expect("collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("Box[Widget]")
    );
}
#[test]
fn loader_java_generic_param_resolves_to_inner_type() {
    let dir = tempdir().unwrap();
    stage(dir.path(), &["graphy-plugin-java"]);
    let reg = PluginRegistry::load_from(&[dir.path().to_path_buf()]).unwrap();

    let src_dir = tempdir().unwrap();
    let java = src_dir.path().join("a.java");
    fs::write(
        &java,
        "public class Widget {}\n\
         public class Svc { public void collect(List<Widget> items) {} }\n",
    )
    .unwrap();
    let out = reg.extract(&java).unwrap().unwrap();

    // The List container is suppressed; the has_param edge resolves to the
    // inner Widget. Survives the FFI + loader round-trip.
    let hp: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param")
        .collect();
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::List")
    );

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.label == "collect")
        .expect("collect node");
    assert_eq!(
        collect
            .signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("List<Widget>")
    );
}
