use crate::config::Settings;
use crate::format::scientific::format_scientific;
use crate::format::ZERO_EPSILON;
use crate::funcs::rounding::round_to_places;

pub fn format_value(value: f64, settings: &Settings) -> String {
    if value.abs() < ZERO_EPSILON {
        return "0".to_string();
    }
    if value.abs() >= settings.sci_threshold || value.abs() < 1e-6 {
        return format_scientific(value, settings.precision);
    }
    let rounded = round_to_places(value, settings.precision);
    if rounded.fract() == 0.0 {
        return format!("{}", rounded as i64);
    }
    format!("{rounded}")
}
