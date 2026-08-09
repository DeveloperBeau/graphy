package calc.errors

class LexException(message: String) : CalcException("lex", message) {

    companion object {
        /** Convenience for errors tied to a column in the source line. */
        fun at(message: String, position: Int): LexException =
            LexException(message + " at column " + position)
    }
}
