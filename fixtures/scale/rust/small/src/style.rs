use crate::errors::PrintError;

#[derive(Clone, Copy, PartialEq)]
pub enum Style {
    Plain,
    Upper,
    Lower,
    Title,
}

pub fn apply_style(text: &str, style: Style) -> String {
    match style {
        Style::Plain => text.to_string(),
        Style::Upper => text.to_uppercase(),
        Style::Lower => text.to_lowercase(),
        Style::Title => text.split_whitespace().map(title_word).collect::<Vec<_>>().join(" "),
    }
}

fn title_word(word: &str) -> String {
    let mut chars = word.chars();
    match chars.next() {
        Some(first) => first.to_uppercase().collect::<String>() + chars.as_str(),
        None => String::new(),
    }
}

pub fn parse_style(raw: Option<String>) -> Result<Style, PrintError> {
    match raw.as_deref() {
        Some("plain") => Ok(Style::Plain),
        Some("upper") => Ok(Style::Upper),
        Some("lower") => Ok(Style::Lower),
        Some("title") => Ok(Style::Title),
        Some(other) => Err(PrintError::UnknownChoice("--style", other.to_string())),
        None => Err(PrintError::MissingValue("--style")),
    }
}
