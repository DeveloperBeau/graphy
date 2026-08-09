use crate::cli::commands::{handle_command, CommandOutcome};
use crate::cli::is_command;
use crate::cli::line::eval_line;
use crate::cli::prompt::read_line;
use crate::config::Settings;
use crate::errors::CalcError;
use crate::eval::env::Env;
use crate::history::HistoryLog;

pub fn run_repl(settings: Settings) -> Result<(), CalcError> {
    let mut env = Env::new(settings.clone());
    let limit = crate::history::clamp_limit(settings.history_limit);
    let mut history = HistoryLog::with_limit(limit);
    loop {
        let Some(line) = read_line()? else { break };
        let trimmed = line.trim();
        if trimmed.is_empty() {
            continue;
        }
        if is_command(trimmed) {
            match handle_command(trimmed, &mut env, &history) {
                CommandOutcome::Continue => continue,
                CommandOutcome::Quit => break,
            }
        }
        eval_line(trimmed, &mut env, &mut history);
    }
    Ok(())
}
