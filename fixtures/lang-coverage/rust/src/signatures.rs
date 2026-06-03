//! Fixture for the typed signature layer.

pub struct Widget {
    pub label: String,
    pub size: u32,
}

pub fn build(widget: Widget, count: u32) -> Widget {
    let _ = count;
    widget
}

pub struct Holder {
    pub item: Widget,
    pub count: u32,
}

pub fn order(count: u32, widget: Widget) -> Widget {
    let _ = count;
    widget
}

pub fn external(p: std::path::PathBuf) -> Widget {
    Widget { label: String::new(), size: 0 }
}

pub struct Foo {
    pub a: u32,
}

pub struct Bar {
    pub b: u32,
}

pub fn generic(items: Vec<Widget>, pair: Pair<Foo, Bar>) {
    let _ = (items, pair);
}
