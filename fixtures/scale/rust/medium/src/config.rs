#[derive(Clone, Copy, PartialEq)]
pub enum AngleMode {
    Radians,
    Degrees,
}

#[derive(Clone)]
pub struct Settings {
    pub precision: usize,
    pub angle_mode: AngleMode,
    pub sci_threshold: f64,
    pub history_limit: usize,
}

impl Settings {
    pub fn from_env() -> Self {
        let precision = std::env::var("DESKCALC_PRECISION")
            .ok()
            .and_then(|raw| raw.parse().ok())
            .unwrap_or(6);
        Settings {
            precision,
            angle_mode: AngleMode::Radians,
            sci_threshold: 1e12,
            history_limit: 200,
        }
    }
}
