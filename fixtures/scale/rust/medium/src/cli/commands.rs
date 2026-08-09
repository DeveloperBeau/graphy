use crate::config::AngleMode;
use crate::eval::env::Env;
use crate::format::help::help_text;
use crate::format::table::{format_listing, format_pairs};
use crate::history::HistoryLog;

pub enum CommandOutcome {
    Continue,
    Quit,
}

pub fn handle_command(line: &str, env: &mut Env, history: &HistoryLog) -> CommandOutcome {
    match line.trim() {
        ":quit" | ":q" | ":exit" => return CommandOutcome::Quit,
        ":help" => println!("{}", help_text()),
        ":vars" => {
            let pairs = env.vars.snapshot();
            for row in format_pairs(&pairs) {
                println!("{row}");
            }
        }
        ":history" => println!("{}", format_listing(&history.recent())),
        ":deg" => env.settings.angle_mode = AngleMode::Degrees,
        ":rad" => env.settings.angle_mode = AngleMode::Radians,
        other => eprintln!("unknown command {other}, try :help"),
    }
    CommandOutcome::Continue
}
