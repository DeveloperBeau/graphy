use crate::errors::CalcError;
use std::io::{BufRead, Write};

/// Read one line from stdin, returning None on EOF.
pub fn read_line() -> Result<Option<String>, CalcError> {
    print!("> ");
    std::io::stdout()
        .flush()
        .map_err(|err| CalcError::Io(err.to_string()))?;
    let mut buf = String::new();
    let read = std::io::stdin()
        .lock()
        .read_line(&mut buf)
        .map_err(|err| CalcError::Io(err.to_string()))?;
    if read == 0 {
        return Ok(None);
    }
    Ok(Some(buf))
}
