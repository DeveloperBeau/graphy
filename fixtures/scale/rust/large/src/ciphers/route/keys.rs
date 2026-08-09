/// Key material for the route family (grid geometry).
pub const ROUTE_KEY_KIND: &str = "grid geometry";

pub fn route_default_key() -> usize {
    6
}

/// One-line key description for the report footer.
pub fn route_key_label() -> String {
    format!("route <{}>", ROUTE_KEY_KIND)
}
