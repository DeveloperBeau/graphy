package calc.ast

data class VariableExpr(val name: String) : Expr {

    override fun describe(): String = name

    fun isConstantName(): Boolean = name in CONSTANT_NAMES

    companion object {
        private val CONSTANT_NAMES = setOf("pi", "e", "phi", "tau")
    }
}
