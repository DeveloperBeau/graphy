use crate::errors::CalcError;
use crate::lexer::cursor::Cursor;
use crate::lexer::ident::{is_ident_start, scan_ident};
use crate::lexer::number::scan_number;
use crate::lexer::token::Token;

pub fn scan_tokens(input: &str) -> Result<Vec<Token>, CalcError> {
    let mut cursor = Cursor::new(input);
    let mut tokens = Vec::new();
    while let Some(ch) = cursor.peek() {
        match ch {
            ' ' | '\t' => {
                cursor.bump();
            }
            '0'..='9' | '.' => tokens.push(scan_number(&mut cursor)?),
            ch if is_ident_start(ch) => tokens.push(scan_ident(&mut cursor)),
            _ => {
                cursor.bump();
                tokens.push(match ch {
                    '+' => Token::Plus,
                    '-' => Token::Minus,
                    '*' => Token::Star,
                    '/' => Token::Slash,
                    '%' => Token::Percent,
                    '^' => Token::Caret,
                    '!' => Token::Bang,
                    '(' => Token::LParen,
                    ')' => Token::RParen,
                    ',' => Token::Comma,
                    '=' => Token::Equals,
                    other => return Err(CalcError::UnexpectedChar(other)),
                });
            }
        }
    }
    Ok(tokens)
}
