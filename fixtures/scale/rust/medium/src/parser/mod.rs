pub mod args;
pub mod binary;
pub mod primary;
pub mod state;
pub mod unary;

use crate::ast::Expr;
use crate::errors::CalcError;
use crate::lexer::token::Token;
use state::ParserState;

pub fn parse(tokens: Vec<Token>) -> Result<Expr, CalcError> {
    let mut state = ParserState::new(tokens);
    let expr = binary::parse_expression(&mut state, 0)?;
    state.expect_end()?;
    Ok(expr)
}
