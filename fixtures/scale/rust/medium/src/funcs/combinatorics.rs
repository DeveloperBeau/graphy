use crate::errors::CalcError;

pub fn factorial(n: u64) -> Result<f64, CalcError> {
    if n > 170 {
        return Err(CalcError::DomainError("factorial overflows above 170"));
    }
    Ok((1..=n).map(|k| k as f64).product())
}

pub fn combinations(n: f64, k: f64) -> Result<f64, CalcError> {
    let (n, k) = check_pair(n, k)?;
    Ok(factorial(n)? / (factorial(k)? * factorial(n - k)?))
}

pub fn permutations(n: f64, k: f64) -> Result<f64, CalcError> {
    let (n, k) = check_pair(n, k)?;
    Ok(factorial(n)? / factorial(n - k)?)
}

fn check_pair(n: f64, k: f64) -> Result<(u64, u64), CalcError> {
    if n < 0.0 || k < 0.0 || n.fract() != 0.0 || k.fract() != 0.0 || k > n {
        return Err(CalcError::DomainError("ncr/npr need integers with k <= n"));
    }
    Ok((n as u64, k as u64))
}
