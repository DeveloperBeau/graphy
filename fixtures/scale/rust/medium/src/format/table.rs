/// Two-column layout used by `:vars` and `:history`.
pub fn format_pairs(pairs: &[(String, f64)]) -> Vec<String> {
    let width = pairs.iter().map(|(name, _)| name.len()).max().unwrap_or(0);
    pairs
        .iter()
        .map(|(name, value)| format!("  {name:<width$}  {value}"))
        .collect()
}

pub fn format_listing(lines: &[String]) -> String {
    if lines.is_empty() {
        return "  (empty)".to_string();
    }
    lines
        .iter()
        .map(|line| format!("  {}", crate::format::ellipsize(line, 76)))
        .collect::<Vec<_>>()
        .join("\n")
}
