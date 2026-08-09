package calc.errors

class EvalException(message: String) : CalcException("eval", message) {

    companion object {
        /** Raised when a builtin gets an argument outside its domain. */
        fun domain(function: String): EvalException =
            EvalException(function + " called outside its domain")
    }
}
