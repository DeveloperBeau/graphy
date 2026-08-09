const RESET: &str = "\x1b[0m";

fn code_for(name: &str) -> Option<&'static str> {
    match name {
        "red" => Some("\x1b[31m"),
        "green" => Some("\x1b[32m"),
        "yellow" => Some("\x1b[33m"),
        "blue" => Some("\x1b[34m"),
        "magenta" => Some("\x1b[35m"),
        "cyan" => Some("\x1b[36m"),
        _ => None,
    }
}

pub fn colorize(text: &str, name: &str) -> String {
    match code_for(name) {
        Some(code) => format!("{code}{text}{RESET}"),
        None => text.to_string(),
    }
}
