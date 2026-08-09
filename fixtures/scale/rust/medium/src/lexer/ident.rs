use crate::lexer::cursor::Cursor;
use crate::lexer::token::Token;

pub fn scan_ident(cursor: &mut Cursor) -> Token {
    let name = cursor.eat_while(|c| c.is_ascii_alphanumeric() || c == '_');
    Token::Ident(name)
}

pub fn is_ident_start(ch: char) -> bool {
    ch.is_ascii_alphabetic() || ch == '_'
}
