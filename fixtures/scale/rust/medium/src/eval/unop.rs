use crate::ast::UnOp;
use crate::errors::CalcError;
use crate::funcs::combinatorics::factorial;

pub fn apply_unop(op: UnOp, value: f64) -> Result<f64, CalcError> {
    match op {
        UnOp::Neg => Ok(-value),
        UnOp::Factorial => {
            if value < 0.0 || value.fract() != 0.0 {
                return Err(CalcError::DomainError("factorial needs a non-negative integer"));
            }
            factorial(value as u64)
        }
    }
}
