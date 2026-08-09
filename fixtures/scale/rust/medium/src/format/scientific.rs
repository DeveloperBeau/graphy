/// Format with a fixed-precision mantissa: 6.02214e23 style.
pub fn format_scientific(value: f64, precision: usize) -> String {
    let formatted = format!("{value:.precision$e}");
    tidy_exponent(&formatted)
}

/// Rust renders `1e5` as `1e5` but `{:e}` keeps a bare exponent; make
/// sure the exponent always carries an explicit sign for readability.
fn tidy_exponent(raw: &str) -> String {
    match raw.split_once('e') {
        Some((mantissa, exp)) if !exp.starts_with('-') => format!("{mantissa}e+{exp}"),
        _ => raw.to_string(),
    }
}
