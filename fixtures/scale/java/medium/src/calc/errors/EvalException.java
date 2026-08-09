package calc.errors;

public class EvalException extends CalcException {
    public EvalException(String message) {
        super("eval", message);
    }

    public static EvalException domain(String function) {
        return new EvalException(function + " called outside its domain");
    }
}
