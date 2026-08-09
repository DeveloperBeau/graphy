use crate::ast::Expr;
use crate::errors::CalcError;
use crate::lexer::token::Token;
use crate::parser::args::parse_call_args;
use crate::parser::binary::parse_expression;
use crate::parser::state::ParserState;

pub fn parse_primary(state: &mut ParserState) -> Result<Expr, CalcError> {
    match state.advance() {
        Some(Token::Number(value)) => Ok(Expr::Number(value)),
        Some(Token::Ident(name)) => finish_ident(state, name),
        Some(Token::LParen) => {
            let inner = parse_expression(state, 0)?;
            if !state.eat(&Token::RParen) {
                return Err(CalcError::UnexpectedEnd);
            }
            Ok(inner)
        }
        Some(other) => Err(CalcError::UnexpectedToken(other.describe())),
        None => Err(CalcError::UnexpectedEnd),
    }
}

fn finish_ident(state: &mut ParserState, name: String) -> Result<Expr, CalcError> {
    if state.eat(&Token::LParen) {
        let call_args = parse_call_args(state)?;
        return Ok(Expr::Call(name, call_args));
    }
    if state.eat(&Token::Equals) {
        let value = parse_expression(state, 0)?;
        return Ok(Expr::Assign(name, Box::new(value)));
    }
    Ok(Expr::Variable(name))
}
