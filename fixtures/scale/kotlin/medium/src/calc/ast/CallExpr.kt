package calc.ast

data class CallExpr(
    val function: String,
    val arguments: List<Expr>,
) : Expr {
    override fun describe(): String =
        function + "/" + arguments.size

    fun arity(): Int = arguments.size
}
