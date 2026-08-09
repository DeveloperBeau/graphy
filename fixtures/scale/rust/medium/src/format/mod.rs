pub mod help;
pub mod number;
pub mod scientific;
pub mod table;

pub use number::format_value;

/// Values below this magnitude are displayed as plain zero.
pub const ZERO_EPSILON: f64 = 1e-12;

/// Trim long listing lines so `:history` stays on one row each.
pub fn ellipsize(text: &str, max: usize) -> String {
    if text.chars().count() <= max {
        return text.to_string();
    }
    let head: String = text.chars().take(max.saturating_sub(3)).collect();
    format!("{head}...")
}
