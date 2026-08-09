use crate::ast::op::symbol;
use crate::ast::Expr;

/// Render an expression back to a readable string, mostly for the
/// `:last` command and for error reporting.
pub fn print_expr(expr: &Expr) -> String {
    match expr {
        Expr::Number(value) => format!("{value}"),
        Expr::Variable(name) => name.clone(),
        Expr::Unary(_, inner) => format!("-({})", print_expr(inner)),
        Expr::Binary(op, lhs, rhs) if crate::ast::depth(expr) <= 2 => {
            format!("{} {} {}", print_expr(lhs), symbol(*op), print_expr(rhs))
        }
        Expr::Binary(op, lhs, rhs) => {
            format!("({} {} {})", print_expr(lhs), symbol(*op), print_expr(rhs))
        }
        Expr::Call(name, args) => {
            let parts: Vec<String> = args.iter().map(print_expr).collect();
            format!("{name}({})", parts.join(", "))
        }
        Expr::Assign(name, value) => format!("{name} = {}", print_expr(value)),
    }
}
