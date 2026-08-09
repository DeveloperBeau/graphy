package calc.ast

data class BinaryExpr(
    val operator: Char,
    val left: Expr,
    val right: Expr,
) : Expr {
    override fun describe(): String =
        "(" + left.describe() + " " + operator + " " + right.describe() + ")"
}
