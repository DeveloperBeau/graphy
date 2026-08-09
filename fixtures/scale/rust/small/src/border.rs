use crate::errors::PrintError;
use crate::width::pad;

#[derive(Clone, Copy, PartialEq)]
pub enum Border {
    None,
    Ascii,
    Rounded,
}

fn charset(border: Border) -> Option<(char, char, [char; 4])> {
    match border {
        Border::None => None,
        Border::Ascii => Some(('-', '|', ['+', '+', '+', '+'])),
        Border::Rounded => Some(('\u{2500}', '\u{2502}', ['\u{256d}', '\u{256e}', '\u{2570}', '\u{256f}'])),
    }
}

pub fn frame(lines: &[String], border: Border, width: usize) -> Vec<String> {
    let Some((h, v, corners)) = charset(border) else { return lines.to_vec() };
    let bar: String = std::iter::repeat(h).take(width + 2).collect();
    let mut out = vec![format!("{}{bar}{}", corners[0], corners[1])];
    for line in lines {
        let fill = pad(width.saturating_sub(crate::width::display_width(line)));
        out.push(format!("{v} {line}{fill} {v}"));
    }
    out.push(format!("{}{bar}{}", corners[2], corners[3]));
    out
}

pub fn parse_border(raw: Option<String>) -> Result<Border, PrintError> {
    match raw.as_deref() {
        Some("none") => Ok(Border::None),
        Some("ascii") => Ok(Border::Ascii),
        Some("rounded") => Ok(Border::Rounded),
        Some(other) => Err(PrintError::UnknownChoice("--border", other.to_string())),
        None => Err(PrintError::MissingValue("--border")),
    }
}
