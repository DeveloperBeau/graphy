use crate::errors::CalcError;
use crate::lexer::token::Token;

pub struct ParserState {
    tokens: Vec<Token>,
    pos: usize,
}

impl ParserState {
    pub fn new(tokens: Vec<Token>) -> Self {
        ParserState { tokens, pos: 0 }
    }

    pub fn peek(&self) -> Option<&Token> {
        self.tokens.get(self.pos)
    }

    pub fn advance(&mut self) -> Option<Token> {
        let token = self.tokens.get(self.pos).cloned();
        if token.is_some() {
            self.pos += 1;
        }
        token
    }

    pub fn eat(&mut self, expected: &Token) -> bool {
        if self.peek() == Some(expected) {
            self.pos += 1;
            return true;
        }
        false
    }

    pub fn expect_end(&self) -> Result<(), CalcError> {
        match self.peek() {
            None => Ok(()),
            Some(tok) => Err(CalcError::UnexpectedToken(tok.describe())),
        }
    }
}
