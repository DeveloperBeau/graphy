use crate::ast::Expr;
use crate::errors::CalcError;
use crate::eval::env::Env;
use crate::eval::walker::eval_expr;
use crate::funcs::dispatch::call_function;

pub fn eval_call(name: &str, args: &[Expr], env: &mut Env) -> Result<f64, CalcError> {
    let mut values = Vec::with_capacity(args.len());
    for arg in args {
        values.push(eval_expr(arg, env)?);
    }
    call_function(name, &values, &env.settings)
}
