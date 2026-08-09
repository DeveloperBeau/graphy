use crate::ast::Expr;
use crate::errors::CalcError;
use crate::lexer::token::Token;
use crate::parser::binary::parse_expression;
use crate::parser::state::ParserState;

pub fn parse_call_args(state: &mut ParserState) -> Result<Vec<Expr>, CalcError> {
    let mut args = Vec::new();
    if state.eat(&Token::RParen) {
        return Ok(args);
    }
    loop {
        args.push(parse_expression(state, 0)?);
        if state.eat(&Token::Comma) {
            continue;
        }
        if state.eat(&Token::RParen) {
            return Ok(args);
        }
        return Err(CalcError::UnexpectedEnd);
    }
}
