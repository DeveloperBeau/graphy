pub fn apply_rounding(name: &str, x: f64) -> f64 {
    match name {
        "round" => x.round(),
        "floor" => x.floor(),
        "ceil" => x.ceil(),
        _ => x.abs(),
    }
}

/// Round to a fixed number of decimal places; used by the formatter
/// rather than exposed as a calculator function.
pub fn round_to_places(x: f64, places: usize) -> f64 {
    let factor = 10f64.powi(places as i32);
    (x * factor).round() / factor
}
