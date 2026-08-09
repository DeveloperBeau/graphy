use crate::config::AngleMode;
use crate::errors::CalcError;

pub fn apply_trig(name: &str, input: f64, mode: AngleMode) -> Result<f64, CalcError> {
    let x = match mode {
        AngleMode::Radians => input,
        AngleMode::Degrees => input.to_radians(),
    };
    let result = match name {
        "sin" => x.sin(),
        "cos" => x.cos(),
        "tan" => x.tan(),
        "asin" => input.asin(),
        "acos" => input.acos(),
        "atan" => input.atan(),
        _ => return Err(CalcError::UnknownFunction(name.to_string())),
    };
    if result.is_nan() {
        return Err(CalcError::DomainError("inverse trig input out of range"));
    }
    Ok(back_convert(name, result, mode))
}

fn back_convert(name: &str, value: f64, mode: AngleMode) -> f64 {
    let inverse = matches!(name, "asin" | "acos" | "atan");
    if inverse && mode == AngleMode::Degrees {
        return value.to_degrees();
    }
    value
}
