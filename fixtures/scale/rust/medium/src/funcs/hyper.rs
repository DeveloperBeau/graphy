use crate::errors::CalcError;

pub fn apply_hyperbolic(name: &str, x: f64) -> Result<f64, CalcError> {
    match name {
        "sinh" => Ok(x.sinh()),
        "cosh" => Ok(x.cosh()),
        "tanh" => Ok(x.tanh()),
        _ => Err(CalcError::UnknownFunction(name.to_string())),
    }
}
