use crate::config::Settings;
use crate::errors::CalcError;
use crate::funcs::combinatorics::{combinations, permutations};
use crate::funcs::exp_log::{exp_e, log_base10, log_natural, square_root};
use crate::funcs::hyper::apply_hyperbolic;
use crate::funcs::rounding::apply_rounding;
use crate::funcs::stats::stat_dispatch;
use crate::funcs::trig::apply_trig;

pub fn call_function(name: &str, args: &[f64], settings: &Settings) -> Result<f64, CalcError> {
    match name {
        "sin" | "cos" | "tan" | "asin" | "acos" | "atan" => {
            expect_arity(name, args, 1)?;
            apply_trig(name, args[0], settings.angle_mode)
        }
        "sinh" | "cosh" | "tanh" => {
            expect_arity(name, args, 1)?;
            apply_hyperbolic(name, args[0])
        }
        "round" | "floor" | "ceil" | "abs" => {
            expect_arity(name, args, 1)?;
            Ok(apply_rounding(name, args[0]))
        }
        "ln" => expect_arity(name, args, 1).and_then(|_| log_natural(args[0])),
        "log" => expect_arity(name, args, 1).and_then(|_| log_base10(args[0])),
        "exp" => expect_arity(name, args, 1).map(|_| exp_e(args[0])),
        "sqrt" => expect_arity(name, args, 1).and_then(|_| square_root(args[0])),
        "min" | "max" | "mean" | "sum" => stat_dispatch(name, args),
        "ncr" => expect_arity(name, args, 2).and_then(|_| combinations(args[0], args[1])),
        "npr" => expect_arity(name, args, 2).and_then(|_| permutations(args[0], args[1])),
        _ => Err(CalcError::UnknownFunction(name.to_string())),
    }
}

fn expect_arity(name: &str, args: &[f64], want: usize) -> Result<(), CalcError> {
    if args.len() != want {
        return Err(CalcError::WrongArity(name.to_string(), args.len()));
    }
    Ok(())
}
