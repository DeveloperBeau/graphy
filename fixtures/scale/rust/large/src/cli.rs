use crate::bench::registry;
use crate::bench::runner::run_all;
use crate::core::errors::CipherError;
use crate::db::pathutil::default_db_path;
use crate::db::RunStore;

fn flag_value(args: &[String], flag: &str) -> Option<String> {
    args.iter()
        .position(|a| a == flag)
        .and_then(|i| args.get(i + 1))
        .cloned()
}

pub fn run(args: Vec<String>) -> Result<(), CipherError> {
    let size: usize = flag_value(&args, "--size")
        .and_then(|raw| raw.parse().ok())
        .unwrap_or(4096);
    let only = flag_value(&args, "--only");
    let mut entries = registry();
    if let Some(name) = only {
        entries.retain(|entry| entry.name == name);
        if entries.is_empty() {
            return Err(CipherError::BadInput("--only matched no cipher family"));
        }
    }
    let sweep = args.iter().any(|a| a == "--sweep");
    let sizes = if sweep { crate::bench::collect::sweep_sizes() } else { vec![size] };
    let db_path = default_db_path();
    let prior_runs = RunStore::load(&db_path).len();
    let mut store = RunStore::new(db_path);
    for input_len in sizes {
        let summary = run_all(&entries, input_len, &mut store);
        summary.print_final();
    }
    store.save()?;
    println!("recorded {} runs (file previously held {prior_runs})", store.len());
    Ok(())
}
