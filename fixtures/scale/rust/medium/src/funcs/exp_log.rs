use crate::errors::CalcError;

pub fn log_natural(x: f64) -> Result<f64, CalcError> {
    if x <= 0.0 {
        return Err(CalcError::DomainError("ln needs a positive argument"));
    }
    Ok(x.ln())
}

pub fn log_base10(x: f64) -> Result<f64, CalcError> {
    if x <= 0.0 {
        return Err(CalcError::DomainError("log needs a positive argument"));
    }
    Ok(x.log10())
}

pub fn exp_e(x: f64) -> f64 {
    x.exp()
}

pub fn square_root(x: f64) -> Result<f64, CalcError> {
    if x < 0.0 {
        return Err(CalcError::DomainError("sqrt needs a non-negative argument"));
    }
    Ok(x.sqrt())
}
