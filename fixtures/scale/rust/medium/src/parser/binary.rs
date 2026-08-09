use crate::ast::{BinOp, Expr};
use crate::errors::CalcError;
use crate::lexer::token::Token;
use crate::parser::state::ParserState;
use crate::parser::unary::parse_unary;

fn binding_power(token: &Token) -> Option<(BinOp, u8, u8)> {
    match token {
        Token::Plus => Some((BinOp::Add, 1, 2)),
        Token::Minus => Some((BinOp::Sub, 1, 2)),
        Token::Star => Some((BinOp::Mul, 3, 4)),
        Token::Slash => Some((BinOp::Div, 3, 4)),
        Token::Percent => Some((BinOp::Rem, 3, 4)),
        Token::Caret => Some((BinOp::Pow, 6, 5)),
        _ => None,
    }
}

pub fn parse_expression(state: &mut ParserState, min_power: u8) -> Result<Expr, CalcError> {
    let mut lhs = parse_unary(state)?;
    while let Some(token) = state.peek() {
        let Some((op, left_power, right_power)) = binding_power(token) else {
            break;
        };
        if left_power < min_power {
            break;
        }
        state.advance();
        let rhs = parse_expression(state, right_power)?;
        lhs = Expr::binary(op, lhs, rhs);
    }
    Ok(lhs)
}
