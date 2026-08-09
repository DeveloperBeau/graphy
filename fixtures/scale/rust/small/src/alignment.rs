use crate::errors::PrintError;
use crate::width::{display_width, pad};

#[derive(Clone, Copy, PartialEq)]
pub enum Alignment {
    Left,
    Right,
    Center,
}

pub fn align_line(line: &str, width: usize, align: Alignment) -> String {
    let used = display_width(line);
    if used >= width {
        return crate::width::truncate_to(line, width);
    }
    let gap = width - used;
    match align {
        Alignment::Left => format!("{line}{}", pad(gap)),
        Alignment::Right => format!("{}{line}", pad(gap)),
        Alignment::Center => {
            let left = gap / 2;
            format!("{}{line}{}", pad(left), pad(gap - left))
        }
    }
}

pub fn parse_align(raw: Option<String>) -> Result<Alignment, PrintError> {
    match raw.as_deref() {
        Some("left") => Ok(Alignment::Left),
        Some("right") => Ok(Alignment::Right),
        Some("center") => Ok(Alignment::Center),
        Some(other) => Err(PrintError::UnknownChoice("--align", other.to_string())),
        None => Err(PrintError::MissingValue("--align")),
    }
}
