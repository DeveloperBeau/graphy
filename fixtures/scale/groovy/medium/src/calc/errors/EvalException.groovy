package calc.errors

class EvalException extends CalcException {
    EvalException(String message) {
        super("eval", message)
    }

    static EvalException domain(String function) {
        return new EvalException(function + " called outside its domain")
    }
}
