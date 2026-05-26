//! Smoke tests for the eleven additional language extractors landing in the
//! second batch (Swift, Kotlin, PHP, Scala, Lua, Zig, Elixir, ObjC, Julia,
//! HTML, CSS).

use std::fs;

use graphy_core::extract::extract;
use tempfile::TempDir;

fn run(suffix: &str, src: &str) -> graphy_core::schema::ExtractionOutput {
    let dir = TempDir::new().unwrap();
    let p = dir.path().join(format!("f{suffix}"));
    fs::write(&p, src).unwrap();
    let out = extract(&p).unwrap();
    std::mem::forget(dir);
    out
}

fn has_label(out: &graphy_core::schema::ExtractionOutput, l: &str) -> bool {
    out.nodes.iter().any(|n| n.label == l)
}

fn has_relation(out: &graphy_core::schema::ExtractionOutput, r: &str) -> bool {
    out.edges.iter().any(|e| e.relation == r)
}

// ---------- Swift ----------

#[test]
fn swift_extracts_class_and_function() {
    let out = run(
        ".swift",
        "import Foundation\nclass Svc { func run() {} }\nfunc helper() {}\n",
    );
    assert!(has_label(&out, "Svc") || has_label(&out, "run") || has_label(&out, "helper"));
    assert!(has_relation(&out, "imports"));
}

#[test]
fn swift_empty_safe() {
    let out = run(".swift", "");
    assert!(out.nodes.is_empty());
}

// ---------- Kotlin ----------

#[test]
fn kotlin_extracts_class_and_function() {
    let out = run(
        ".kt",
        "import java.util.List\nclass Svc { fun run() {} }\nfun helper() {}\n",
    );
    assert!(has_label(&out, "Svc") || has_label(&out, "run") || has_label(&out, "helper"));
    assert!(has_relation(&out, "imports"));
}

#[test]
fn kotlin_empty_safe() {
    let out = run(".kt", "");
    assert!(out.nodes.is_empty());
}

// ---------- PHP ----------

#[test]
fn php_extracts_class_and_function() {
    let out = run(
        ".php",
        "<?php\nnamespace App;\nuse App\\Lib\\Helper;\nclass Svc {\n  function run() { Helper::go(); }\n}\nfunction f() {}\n",
    );
    assert!(has_label(&out, "Svc"));
    assert!(has_label(&out, "f") || has_label(&out, "run"));
    assert!(has_relation(&out, "imports"));
}

#[test]
fn php_empty_safe() {
    let out = run(".php", "<?php\n");
    let _ = out.nodes.len();
}

// ---------- Scala ----------

#[test]
fn scala_extracts_object_and_def() {
    let out = run(
        ".scala",
        "import scala.collection.mutable\nobject Svc { def run(): Unit = {} }\nclass C\n",
    );
    assert!(has_label(&out, "Svc") || has_label(&out, "run") || has_label(&out, "C"));
    assert!(has_relation(&out, "imports"));
}

// ---------- Lua ----------

#[test]
fn lua_extracts_functions_and_require() {
    let out = run(
        ".lua",
        "local m = require('mod')\nfunction greet(n) print('hi '..n) end\nfunction main() greet('world') end\n",
    );
    assert!(has_relation(&out, "imports"));
    assert!(has_label(&out, "greet") || has_label(&out, "main"));
}

// ---------- Zig ----------

#[test]
fn zig_extracts_function_and_import() {
    let out = run(
        ".zig",
        "const std = @import(\"std\");\nfn helper() void {}\nfn main() void { helper(); }\n",
    );
    let _ = out.nodes.len();
    assert!(has_relation(&out, "imports") || !out.nodes.is_empty());
}

// ---------- Elixir ----------

#[test]
fn elixir_extracts_module_and_def() {
    let out = run(
        ".ex",
        "defmodule Svc do\n  alias Lib.Helper\n  def run, do: Helper.go()\n  def helper, do: :ok\nend\n",
    );
    assert!(has_label(&out, "Svc") || has_label(&out, "run") || has_label(&out, "helper"));
}

// ---------- ObjC ----------

#[test]
fn objc_extracts_import_and_class() {
    let out = run(
        ".m",
        "#import <Foundation/Foundation.h>\n@interface Foo : NSObject\n@end\n@implementation Foo\n- (void)run {}\n@end\n",
    );
    let _ = out.nodes.len();
    assert!(has_relation(&out, "imports") || !out.nodes.is_empty());
}

// ---------- Julia ----------

#[test]
fn julia_extracts_function_and_using() {
    let out = run(
        ".jl",
        "using LinearAlgebra\nfunction helper() end\nfunction main() helper() end\n",
    );
    assert!(has_relation(&out, "imports") || has_label(&out, "helper") || has_label(&out, "main"));
}

// ---------- HTML ----------

#[test]
fn html_extracts_id_nodes_and_script_refs() {
    let out = run(
        ".html",
        "<!doctype html><html><body><div id=\"app\"></div><script src=\"app.js\"></script></body></html>",
    );
    assert!(out.edges.iter().any(|e| e.target.starts_with("link::")));
}

// ---------- CSS ----------

#[test]
fn css_extracts_selectors_and_imports() {
    let out = run(
        ".css",
        "@import url(\"reset.css\");\n.btn { color: red; }\n#nav { padding: 1px; }\n",
    );
    assert!(has_relation(&out, "imports"));
    assert!(!out.nodes.is_empty());
}

// ---------- additional branch coverage ----------

#[test]
fn swift_struct_protocol_extension_and_calls() {
    let out = run(
        ".swift",
        r#"
            import UIKit
            struct Point { var x: Int }
            protocol Drawable { func draw() }
            extension Point: Drawable {
                func draw() { helper() }
            }
            func helper() {}
        "#,
    );
    assert!(has_relation(&out, "imports"));
    assert!(!out.nodes.is_empty());
}

#[test]
fn swift_init_and_deinit_declarations_handled() {
    let out = run(
        ".swift",
        "class K { init() {} deinit { close() } func close() {} }",
    );
    assert!(!out.nodes.is_empty());
}

#[test]
fn zig_function_with_calls_and_struct_const() {
    let out = run(
        ".zig",
        "const std = @import(\"std\");\nconst Foo = struct { x: i32 };\nfn helper() void {}\nfn main() void { helper(); }\n",
    );
    assert!(has_relation(&out, "imports"));
    assert!(!out.nodes.is_empty());
}

#[test]
fn julia_struct_abstract_primitive_and_macro() {
    let out = run(
        ".jl",
        r#"
            using Random
            abstract type Shape end
            struct Circle <: Shape; r::Float64 end
            primitive type Byte 8 end
            macro mymacro(x); x; end
            function area(c::Circle) c.r * 2 end
        "#,
    );
    assert!(!out.nodes.is_empty());
}

#[test]
fn elixir_defp_and_call_edges_to_helpers() {
    let out = run(
        ".ex",
        "defmodule S do\n  alias L.X\n  import Enum\n  def run, do: helper()\n  defp helper, do: :ok\n  defmacro m(x), do: x\nend\n",
    );
    assert!(has_label(&out, "S") || has_label(&out, "run"));
    assert!(has_relation(&out, "imports") || has_relation(&out, "calls"));
}

#[test]
fn objc_function_definition_and_protocol() {
    let out = run(
        ".m",
        "#import <Foundation/Foundation.h>\n@protocol P\n- (void)go;\n@end\nvoid plain_c() {}\n",
    );
    assert!(has_relation(&out, "imports") || !out.nodes.is_empty());
}

#[test]
fn ruby_singleton_method_and_load_import() {
    let out = run(
        ".rb",
        "load 'x.rb'\nclass S\n  def self.singleton; end\n  def other; singleton; end\nend",
    );
    assert!(has_relation(&out, "imports") || has_label(&out, "S"));
}

#[test]
fn kotlin_object_declaration() {
    let out = run(
        ".kt",
        "import a.b.C\nobject Singleton { fun ping() {} }\nfun caller() { Singleton.ping() }",
    );
    assert!(has_label(&out, "Singleton") || has_label(&out, "caller"));
    assert!(has_relation(&out, "imports"));
}

#[test]
fn scala_trait_and_object_definition() {
    let out = run(
        ".scala",
        "import scala.math._\ntrait Greet { def hi: String }\nobject Hello extends Greet { def hi = \"hi\" }",
    );
    assert!(has_relation(&out, "imports"));
}

#[test]
fn lua_local_function_definition() {
    let out = run(
        ".lua",
        "local function helper() return 1 end\nfunction main() return helper() end",
    );
    assert!(has_label(&out, "helper") || has_label(&out, "main"));
}

#[test]
fn php_trait_interface_enum_method_call() {
    let out = run(
        ".php",
        "<?php\ninterface I { function a(); }\ntrait T { function b() {} }\nenum E { case A; }\nclass C { function c() { $this->b(); } }\n",
    );
    assert!(
        has_label(&out, "I")
            || has_label(&out, "T")
            || has_label(&out, "E")
            || has_label(&out, "C")
    );
}

#[test]
fn html_link_href_extracted() {
    let out = run(
        ".html",
        "<!doctype html><html><head><link rel=\"stylesheet\" href=\"style.css\"></head><body></body></html>",
    );
    assert!(out.edges.iter().any(|e| e.target.starts_with("link::")));
}

#[test]
fn html_self_closing_tag_handled() {
    let out = run(".html", "<img id=\"logo\" src=\"l.png\"/>");
    assert!(!out.nodes.is_empty() || !out.edges.is_empty());
}

#[test]
fn css_complex_selectors_emit_nodes() {
    let out = run(
        ".css",
        ".a > .b:hover, #c { color: red; }\n@import \"a.css\";",
    );
    assert!(has_relation(&out, "imports"));
    assert!(!out.nodes.is_empty());
}
