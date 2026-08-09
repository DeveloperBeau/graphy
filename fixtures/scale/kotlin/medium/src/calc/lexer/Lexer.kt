package calc.lexer

import calc.errors.LexException

class Lexer(source: String) {
    private val stream = CharStream(source)

    fun tokenize(): List<Token> {
        val tokens = mutableListOf<Token>()
        stream.skipWhitespace()
        while (stream.hasNext()) {
            val at = stream.position()
            val c = stream.peek()
            when {
                c.isDigit() || c == '.' ->
                    tokens.add(Token(TokenType.NUMBER, stream.takeWhile { it.isDigit() || it == '.' }, at))
                c.isLetter() ->
                    tokens.add(Token(TokenType.IDENTIFIER, stream.takeWhile { it.isLetterOrDigit() }, at))
                else -> {
                    val type = symbolTypeOf(stream.next())
                        ?: throw LexException("unexpected character '" + c + "' at " + at)
                    tokens.add(Token(type, c.toString(), at))
                }
            }
            stream.skipWhitespace()
        }
        tokens.add(Token(TokenType.END, "", stream.position()))
        return tokens
    }
}
