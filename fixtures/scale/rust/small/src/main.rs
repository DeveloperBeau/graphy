mod alignment;
mod border;
mod cli;
mod config;
mod errors;
mod input;
mod render;
mod style;
mod theme;
mod width;
mod wrap;

use std::process::exit;

fn main() {
    let opts = match cli::parse_args(std::env::args().skip(1)) {
        Ok(opts) => opts,
        Err(err) => {
            eprintln!("textprint: {err}");
            exit(2);
        }
    };
    if let Err(err) = cli::run(&opts) {
        eprintln!("textprint: {err}");
        exit(1);
    }
}
