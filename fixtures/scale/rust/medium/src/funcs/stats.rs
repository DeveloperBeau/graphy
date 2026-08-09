use crate::errors::CalcError;

pub fn stat_dispatch(name: &str, args: &[f64]) -> Result<f64, CalcError> {
    match name {
        "min" => stat_min(args),
        "max" => stat_max(args),
        "mean" => stat_mean(args),
        "sum" => Ok(stat_sum(args)),
        other => Err(CalcError::UnknownFunction(other.to_string())),
    }
}

pub fn stat_sum(args: &[f64]) -> f64 {
    args.iter().sum()
}

pub fn stat_mean(args: &[f64]) -> Result<f64, CalcError> {
    if args.is_empty() {
        return Err(CalcError::DomainError("mean needs at least one argument"));
    }
    Ok(stat_sum(args) / args.len() as f64)
}

pub fn stat_min(args: &[f64]) -> Result<f64, CalcError> {
    args.iter()
        .copied()
        .reduce(f64::min)
        .ok_or(CalcError::DomainError("min needs at least one argument"))
}

pub fn stat_max(args: &[f64]) -> Result<f64, CalcError> {
    args.iter()
        .copied()
        .reduce(f64::max)
        .ok_or(CalcError::DomainError("max needs at least one argument"))
}
