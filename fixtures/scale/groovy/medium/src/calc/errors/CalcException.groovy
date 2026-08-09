package calc.errors

/** Base for every error surfaced to the REPL prompt. */
class CalcException extends RuntimeException {
    final String stage

    CalcException(String stage, String message) {
        super(message)
        this.stage = stage
    }

    String describe() {
        return "[" + stage + "] " + message
    }
}
