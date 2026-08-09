use crate::ast::BinOp;
use crate::errors::CalcError;

pub fn apply_binop(op: BinOp, left: f64, right: f64) -> Result<f64, CalcError> {
    match op {
        BinOp::Add => Ok(left + right),
        BinOp::Sub => Ok(left - right),
        BinOp::Mul => Ok(left * right),
        BinOp::Div => {
            if right == 0.0 {
                return Err(CalcError::DivideByZero);
            }
            Ok(left / right)
        }
        BinOp::Rem => {
            if right == 0.0 {
                return Err(CalcError::DivideByZero);
            }
            Ok(left.rem_euclid(right))
        }
        BinOp::Pow => Ok(left.powf(right)),
    }
}
