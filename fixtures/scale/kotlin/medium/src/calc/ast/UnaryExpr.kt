package calc.ast

data class UnaryExpr(
    val operator: Char,
    val operand: Expr,
) : Expr {
    override fun describe(): String =
        operator + operand.describe()

    fun isNegation(): Boolean = operator == '-'
}
