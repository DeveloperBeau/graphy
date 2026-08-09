package calc.lexer

data class Token(
    val type: TokenType,
    val text: String,
    val position: Int,
) {
    fun numberValue(): Double = text.toDouble()

    override fun toString(): String = type.name + "(" + text + ")"
}
