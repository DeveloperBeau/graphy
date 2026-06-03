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
