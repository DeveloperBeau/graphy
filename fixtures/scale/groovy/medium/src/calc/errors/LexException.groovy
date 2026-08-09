package calc.errors

class LexException extends CalcException {
    LexException(String message) {
        super("lex", message)
    }

    static LexException at(String message, int position) {
        return new LexException(message + " at column " + position)
    }
}
