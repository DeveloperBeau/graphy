package calc.errors;

/** Base for every error surfaced to the REPL prompt. */
public class CalcException extends RuntimeException {
    private final String stage;

    public CalcException(String stage, String message) {
        super(message);
        this.stage = stage;
    }

    public String getStage() {
        return stage;
    }
}
