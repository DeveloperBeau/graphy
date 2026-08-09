use crate::config::Options;
use crate::errors::PrintError;
use std::io::Read;

pub fn read_source(opts: &Options) -> Result<String, PrintError> {
    if opts.from_stdin || opts.text.is_empty() {
        let mut buf = String::new();
        std::io::stdin().read_to_string(&mut buf)?;
        Ok(normalize(&buf))
    } else {
        Ok(normalize(&opts.text.join(" ")))
    }
}

fn normalize(raw: &str) -> String {
    raw.replace("\r\n", "\n").trim_end().to_string()
}
