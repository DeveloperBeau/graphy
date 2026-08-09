use std::fmt;

#[derive(Debug, Clone)]
pub enum CalcError {
    UnexpectedChar(char),
    UnexpectedToken(String),
    UnexpectedEnd,
    UnknownFunction(String),
    UnknownVariable(String),
    WrongArity(String, usize),
    DivideByZero,
    DomainError(&'static str),
    Io(String),
}

impl fmt::Display for CalcError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            CalcError::UnexpectedChar(c) => write!(f, "unexpected character {c:?}"),
            CalcError::UnexpectedToken(t) => write!(f, "unexpected token {t}"),
            CalcError::UnexpectedEnd => write!(f, "unexpected end of input"),
            CalcError::UnknownFunction(name) => write!(f, "unknown function {name}"),
            CalcError::UnknownVariable(name) => write!(f, "unknown variable {name}"),
            CalcError::WrongArity(name, n) => write!(f, "{name} does not take {n} arguments"),
            CalcError::DivideByZero => write!(f, "division by zero"),
            CalcError::DomainError(what) => write!(f, "domain error: {what}"),
            CalcError::Io(msg) => write!(f, "io: {msg}"),
        }
    }
}
