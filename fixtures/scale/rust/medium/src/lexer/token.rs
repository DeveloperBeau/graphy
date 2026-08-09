#[derive(Debug, Clone, PartialEq)]
pub enum Token {
    Number(f64),
    Ident(String),
    Plus,
    Minus,
    Star,
    Slash,
    Percent,
    Caret,
    Bang,
    LParen,
    RParen,
    Comma,
    Equals,
}

impl Token {
    pub fn describe(&self) -> String {
        match self {
            Token::Number(value) => format!("number {value}"),
            Token::Ident(name) => format!("identifier {name}"),
            other => format!("{other:?}").to_lowercase(),
        }
    }
}
