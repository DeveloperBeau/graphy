pub mod commands;
pub mod line;
pub mod prompt;
pub mod repl;

/// Prefix that marks a REPL command rather than an expression.
pub const COMMAND_PREFIX: char = ':';

pub fn is_command(line: &str) -> bool {
    line.trim_start().starts_with(COMMAND_PREFIX)
}
