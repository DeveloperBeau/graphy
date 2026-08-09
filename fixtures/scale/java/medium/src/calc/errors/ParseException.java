package calc.errors;

public class ParseException extends CalcException {
    public ParseException(String message) {
        super("parse", message);
    }

    public static ParseException expected(String what) {
        return new ParseException("expected " + what);
    }
}
