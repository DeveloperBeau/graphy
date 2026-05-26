// feature: top-level function, called cross-file

pub fn format_name(name: &str) -> String {
    format!("hi, {name}")
}

pub fn unrelated_helper() -> u32 {
    7
}
