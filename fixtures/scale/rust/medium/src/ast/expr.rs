use crate::ast::op::{BinOp, UnOp};

#[derive(Debug, Clone)]
pub enum Expr {
    Number(f64),
    Variable(String),
    Unary(UnOp, Box<Expr>),
    Binary(BinOp, Box<Expr>, Box<Expr>),
    Call(String, Vec<Expr>),
    Assign(String, Box<Expr>),
}

impl Expr {
    pub fn binary(op: BinOp, lhs: Expr, rhs: Expr) -> Expr {
        Expr::Binary(op, Box::new(lhs), Box::new(rhs))
    }

    pub fn unary(op: UnOp, inner: Expr) -> Expr {
        Expr::Unary(op, Box::new(inner))
    }
}
