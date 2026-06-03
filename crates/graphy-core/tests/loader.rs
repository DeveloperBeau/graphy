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
