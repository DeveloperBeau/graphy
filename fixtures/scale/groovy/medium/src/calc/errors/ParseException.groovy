package calc.errors

class ParseException extends CalcException {
    ParseException(String message) {
        super("parse", message)
    }

    static ParseException expected(String what) {
        return new ParseException("expected " + what)
    }
}
