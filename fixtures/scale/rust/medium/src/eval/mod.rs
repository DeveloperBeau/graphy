pub mod binop;
pub mod call;
pub mod env;
pub mod unop;
pub mod walker;

use crate::ast::Expr;
use crate::errors::CalcError;
use env::Env;

pub fn evaluate(expr: &Expr, env: &mut Env) -> Result<f64, CalcError> {
    let value = walker::eval_expr(expr, env)?;
    env.ans.record(value);
    Ok(value)
}
