use crate::ast::printer::print_expr;
use crate::eval::env::Env;
use crate::eval::evaluate;
use crate::format::format_value;
use crate::history::{HistoryEntry, HistoryLog};
use crate::lexer::tokenize;
use crate::parser::parse;

/// Evaluate one non-command input line and print the outcome.
pub fn eval_line(trimmed: &str, env: &mut Env, history: &mut HistoryLog) {
    let expr = match tokenize(trimmed).and_then(parse) {
        Ok(expr) => expr,
        Err(err) => {
            eprintln!("parse error: {err}");
            return;
        }
    };
    if std::env::var_os("DESKCALC_DEBUG_AST").is_some() {
        eprintln!("ast: {}", print_expr(&expr));
    }
    match evaluate(&expr, env) {
        Ok(value) => {
            history.push(HistoryEntry::new(trimmed, value));
            println!("{}", format_value(value, &env.settings));
        }
        Err(err) => eprintln!("error: {err}"),
    }
}
