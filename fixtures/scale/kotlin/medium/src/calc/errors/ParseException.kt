package calc.errors

class ParseException(message: String) : CalcException("parse", message) {

    companion object {
        /** The common "expected X" parse failure. */
        fun expected(what: String): ParseException =
            ParseException("expected " + what)
    }
}
