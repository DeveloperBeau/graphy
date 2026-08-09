/// Built-in named constants, checked before user variables.
pub fn lookup_constant(name: &str) -> Option<f64> {
    match name {
        "pi" => Some(std::f64::consts::PI),
        "e" => Some(std::f64::consts::E),
        "tau" => Some(std::f64::consts::TAU),
        "phi" => Some(1.618_033_988_749_895),
        _ => None,
    }
}

pub const CONSTANT_NAMES: &[&str] = &["pi", "e", "tau", "phi"];
