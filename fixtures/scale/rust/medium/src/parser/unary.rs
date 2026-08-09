use crate::ast::{Expr, UnOp};
use crate::errors::CalcError;
use crate::lexer::token::Token;
use crate::parser::primary::parse_primary;
use crate::parser::state::ParserState;

pub fn parse_unary(state: &mut ParserState) -> Result<Expr, CalcError> {
    if state.eat(&Token::Minus) {
        let inner = parse_unary(state)?;
        return Ok(Expr::unary(UnOp::Neg, inner));
    }
    let mut expr = parse_primary(state)?;
    while state.eat(&Token::Bang) {
        expr = Expr::unary(UnOp::Factorial, expr);
    }
    Ok(expr)
}
