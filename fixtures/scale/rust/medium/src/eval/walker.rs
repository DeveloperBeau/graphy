use crate::ast::Expr;
use crate::errors::CalcError;
use crate::eval::binop::apply_binop;
use crate::eval::call::eval_call;
use crate::eval::env::Env;
use crate::eval::unop::apply_unop;

pub fn eval_expr(expr: &Expr, env: &mut Env) -> Result<f64, CalcError> {
    match expr {
        Expr::Number(value) => Ok(*value),
        Expr::Variable(name) => lookup_variable(name, env),
        Expr::Unary(op, inner) => {
            let value = eval_expr(inner, env)?;
            apply_unop(*op, value)
        }
        Expr::Binary(op, lhs, rhs) => {
            let left = eval_expr(lhs, env)?;
            let right = eval_expr(rhs, env)?;
            apply_binop(*op, left, right)
        }
        Expr::Call(name, args) => eval_call(name, args, env),
        Expr::Assign(name, value) => {
            let result = eval_expr(value, env)?;
            env.vars.set(name, result);
            Ok(result)
        }
    }
}

fn lookup_variable(name: &str, env: &Env) -> Result<f64, CalcError> {
    if name == "ans" {
        return Ok(env.ans.value());
    }
    env.vars
        .get(name)
        .ok_or_else(|| CalcError::UnknownVariable(name.to_string()))
}
