use crate::alignment::Alignment;
use crate::border::Border;
use crate::errors::PrintError;
use crate::style::Style;

pub struct Options {
    pub width: usize,
    pub align: Alignment,
    pub border: Border,
    pub style: Style,
    pub color: Option<String>,
    pub from_stdin: bool,
    pub text: Vec<String>,
}

impl Default for Options {
    fn default() -> Self {
        Options {
            width: 60,
            align: Alignment::Left,
            border: Border::None,
            style: Style::Plain,
            color: None,
            from_stdin: false,
            text: Vec::new(),
        }
    }
}

pub fn parse_width(raw: Option<String>) -> Result<usize, PrintError> {
    raw.ok_or(PrintError::MissingValue("--width"))?
        .parse()
        .map_err(|_| PrintError::BadNumber("--width"))
}
