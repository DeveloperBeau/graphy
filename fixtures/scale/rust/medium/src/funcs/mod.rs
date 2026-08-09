pub mod combinatorics;
pub mod constants;
pub mod dispatch;
pub mod exp_log;
pub mod hyper;
pub mod rounding;
pub mod stats;
pub mod trig;

/// Names accepted by `dispatch::call_function`, surfaced by `:help`.
pub const FUNCTION_NAMES: &[&str] = &[
    "sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh",
    "ln", "log", "exp", "sqrt", "round", "floor", "ceil", "abs",
    "min", "max", "mean", "sum", "ncr", "npr",
];
