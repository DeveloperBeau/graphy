package calc.errors;

public class LexException extends CalcException {
    public LexException(String message) {
        super("lex", message);
    }

    public static LexException at(String message, int position) {
        return new LexException(message + " at column " + position);
    }
}
