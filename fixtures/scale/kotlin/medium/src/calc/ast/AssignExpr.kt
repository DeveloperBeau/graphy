package calc.ast

data class AssignExpr(
    val name: String,
    val value: Expr,
) : Expr {
    override fun describe(): String =
        name + " = " + value.describe()

    fun isSelfReference(): Boolean =
        value is VariableExpr && value.name == name
}
