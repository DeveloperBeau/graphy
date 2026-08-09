package calc.util

fun trimTrailingZeros(formatted: String): String {
    if ('.' !in formatted) return formatted
    return formatted.trimEnd('0').trimEnd('.')
}

/** Format an integer with thousands separators for the :vars listing. */
fun grouped(value: Long): String =
    String.format("%,d", value)
