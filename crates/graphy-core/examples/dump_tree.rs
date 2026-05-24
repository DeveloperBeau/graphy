//! Probe utility: parse a source string with a given tree-sitter language and
//! print the node kinds. `cargo run --example dump_tree -- kotlin "import x"`.

use tree_sitter::{Node, Parser};

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let lang = args.get(1).map(|s| s.as_str()).unwrap_or("kotlin");
    let src = args.get(2).cloned().unwrap_or_else(|| {
        "import java.util.List\nclass Svc { fun run() {} }".into()
    });

    let lf: tree_sitter::Language = match lang {
        "kotlin" => tree_sitter_kotlin_ng::LANGUAGE.into(),
        "html" => tree_sitter_html::LANGUAGE.into(),
        "swift" => tree_sitter_swift::LANGUAGE.into(),
        "scala" => tree_sitter_scala::LANGUAGE.into(),
        "zig" => tree_sitter_zig::LANGUAGE.into(),
        "julia" => tree_sitter_julia::LANGUAGE.into(),
        "elixir" => tree_sitter_elixir::LANGUAGE.into(),
        "lua" => tree_sitter_lua::LANGUAGE.into(),
        "objc" => tree_sitter_objc::LANGUAGE.into(),
        "ruby" => tree_sitter_ruby::LANGUAGE.into(),
        "php" => tree_sitter_php::LANGUAGE_PHP.into(),
        _ => panic!("unknown lang: {lang}"),
    };
    let mut parser = Parser::new();
    parser.set_language(&lf).unwrap();
    let tree = parser.parse(&src, None).unwrap();
    walk(tree.root_node(), &src, 0);
}

fn walk(n: Node, src: &str, depth: usize) {
    let kind = n.kind();
    let text = n
        .utf8_text(src.as_bytes())
        .unwrap_or("")
        .replace('\n', " ");
    let snippet = if text.len() > 60 { &text[..60] } else { &text };
    println!("{:>3}: {}{} -- {}", n.start_position().row, "  ".repeat(depth), kind, snippet);
    let mut cursor = n.walk();
    for c in n.children(&mut cursor) {
        walk(c, src, depth + 1);
    }
}
