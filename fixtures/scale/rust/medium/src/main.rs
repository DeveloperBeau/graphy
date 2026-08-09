mod ast;
mod cli;
mod config;
mod errors;
mod eval;
mod format;
mod funcs;
mod history;
mod lexer;
mod memory;
mod parser;

use crate::cli::repl::run_repl;
use crate::config::Settings;

fn main() {
    let settings = Settings::from_env();
    if let Err(err) = run_repl(settings) {
        eprintln!("deskcalc: {err}");
        std::process::exit(1);
    }
}
