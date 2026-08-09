mod bench;
mod cli;
mod ciphers;
mod core;
mod db;
mod live;

fn main() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    if let Err(err) = cli::run(args) {
        eprintln!("cipherbench: {err}");
        std::process::exit(1);
    }
}
