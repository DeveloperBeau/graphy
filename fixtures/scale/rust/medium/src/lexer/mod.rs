pub mod cursor;
pub mod ident;
pub mod number;
pub mod scanner;
pub mod token;

use crate::errors::CalcError;
use token::Token;

/// Tokenize a full input line.
pub fn tokenize(input: &str) -> Result<Vec<Token>, CalcError> {
    scanner::scan_tokens(input)
}
