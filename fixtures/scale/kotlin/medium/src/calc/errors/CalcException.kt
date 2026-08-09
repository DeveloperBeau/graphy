package calc.errors

/** Base for every error surfaced to the REPL prompt. */
open class CalcException(
    val stage: String,
    message: String,
) : RuntimeException(message) {

    fun describe(): String = "[" + stage + "] " + message
}
