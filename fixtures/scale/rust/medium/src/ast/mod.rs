pub mod expr;
pub mod op;
pub mod printer;

pub use expr::Expr;
pub use op::{BinOp, UnOp};

/// Depth of an expression tree, used by the pretty-printer to decide
/// whether to add grouping parentheses.
pub fn depth(expr: &Expr) -> usize {
    match expr {
        Expr::Number(_) | Expr::Variable(_) => 1,
        Expr::Unary(_, inner) => 1 + depth(inner),
        Expr::Binary(_, lhs, rhs) => 1 + depth(lhs).max(depth(rhs)),
        Expr::Call(_, args) => 1 + args.iter().map(depth).max().unwrap_or(0),
        Expr::Assign(_, value) => 1 + depth(value),
    }
}
