use std::fmt;

#[derive(Debug)]
pub enum CipherError {
    BadKey(&'static str),
    BadInput(&'static str),
    Io(String),
}

impl fmt::Display for CipherError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            CipherError::BadKey(why) => write!(f, "bad key: {why}"),
            CipherError::BadInput(why) => write!(f, "bad input: {why}"),
            CipherError::Io(why) => write!(f, "io error: {why}"),
        }
    }
}

impl From<std::io::Error> for CipherError {
    fn from(err: std::io::Error) -> Self {
        CipherError::Io(err.to_string())
    }
}
