package calc.ast

data class NumberExpr(val value: Double) : Expr {

    override fun describe(): String = value.toString()

    companion object {
        val ZERO = NumberExpr(0.0)
    }
}
