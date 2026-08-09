use crate::alignment::align_line;
use crate::border::frame;
use crate::config::Options;
use crate::errors::PrintError;
use crate::style::apply_style;
use crate::theme::colorize;
use crate::wrap::wrap_text;

pub fn render(text: &str, opts: &Options) -> Result<String, PrintError> {
    let styled = apply_style(text, opts.style);
    let lines = wrap_text(&styled, opts.width);
    let aligned: Vec<String> = lines
        .iter()
        .map(|line| align_line(line, opts.width, opts.align))
        .collect();
    let framed = frame(&aligned, opts.border, opts.width);
    let joined = framed.join("\n");
    match &opts.color {
        Some(name) => Ok(colorize(&joined, name)),
        None => Ok(joined),
    }
}
