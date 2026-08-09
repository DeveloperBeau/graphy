use std::fmt;

#[derive(Debug)]
pub enum PrintError {
    MissingValue(&'static str),
    BadNumber(&'static str),
    UnknownChoice(&'static str, String),
    Io(std::io::Error),
}

impl fmt::Display for PrintError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            PrintError::MissingValue(flag) => write!(f, "{flag} needs a value"),
            PrintError::BadNumber(flag) => write!(f, "{flag} expects a number"),
            PrintError::UnknownChoice(flag, got) => write!(f, "{flag}: unknown choice {got:?}"),
            PrintError::Io(err) => write!(f, "io error: {err}"),
        }
    }
}

impl From<std::io::Error> for PrintError {
    fn from(err: std::io::Error) -> Self {
        PrintError::Io(err)
    }
}
