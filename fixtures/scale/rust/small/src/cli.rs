use crate::config::Options;
use crate::errors::PrintError;
use crate::input::read_source;
use crate::render::render;

pub fn parse_args(args: impl Iterator<Item = String>) -> Result<Options, PrintError> {
    let mut opts = Options::default();
    let mut it = args.peekable();
    while let Some(arg) = it.next() {
        match arg.as_str() {
            "-w" | "--width" => opts.width = crate::config::parse_width(it.next())?,
            "-a" | "--align" => opts.align = crate::alignment::parse_align(it.next())?,
            "-b" | "--border" => opts.border = crate::border::parse_border(it.next())?,
            "-s" | "--style" => opts.style = crate::style::parse_style(it.next())?,
            "-c" | "--color" => opts.color = it.next(),
            "-" => opts.from_stdin = true,
            other => opts.text.push(other.to_string()),
        }
    }
    Ok(opts)
}

pub fn run(opts: &Options) -> Result<(), PrintError> {
    let text = read_source(opts)?;
    let framed = render(&text, opts)?;
    println!("{framed}");
    Ok(())
}
