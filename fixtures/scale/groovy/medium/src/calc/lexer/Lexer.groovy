package calc.lexer

import calc.errors.LexException

class Lexer {
    private final CharStream stream

    Lexer(String source) {
        this.stream = new CharStream(source)
    }

    List<Token> tokenize() {
        List<Token> tokens = []
        stream.skipWhitespace()
        while (stream.hasNext()) {
            int at = stream.position()
            char c = stream.peek()
            if (Character.isDigit(c) || c == ('.' as char)) {
                tokens << new Token(TokenType.NUMBER, stream.takeWhile { Character.isDigit(it) || it == ('.' as char) }, at)
            } else if (Character.isLetter(c)) {
                tokens << new Token(TokenType.IDENTIFIER, stream.takeWhile { Character.isLetterOrDigit(it) }, at)
            } else {
                TokenType type = Symbols.typeOf(stream.next())
                if (type == null) throw new LexException("unexpected character '" + c + "' at " + at)
                tokens << new Token(type, c as String, at)
            }
            stream.skipWhitespace()
        }
        tokens << new Token(TokenType.END, "", stream.position())
        return tokens
    }
}
