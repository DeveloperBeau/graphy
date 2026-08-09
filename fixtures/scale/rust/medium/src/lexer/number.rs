use crate::errors::CalcError;
use crate::lexer::cursor::Cursor;
use crate::lexer::token::Token;

pub fn scan_number(cursor: &mut Cursor) -> Result<Token, CalcError> {
    let mut text = cursor.eat_while(|c| c.is_ascii_digit() || c == '.');
    if matches!(cursor.peek(), Some('e') | Some('E')) {
        text.push(cursor.bump().expect("peeked"));
        if matches!(cursor.peek(), Some('+') | Some('-')) {
            text.push(cursor.bump().expect("peeked"));
        }
        text.push_str(&cursor.eat_while(|c| c.is_ascii_digit()));
    }
    text.parse::<f64>()
        .map(Token::Number)
        .map_err(|_| CalcError::UnexpectedToken(text))
}
