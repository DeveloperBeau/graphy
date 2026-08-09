package cryptobench.ciphers.adfgvx

/** Substitution between grid cells and ADFGVX symbol pairs. */
internal object AdfgvxSymbols {
    const val SYMBOLS = "ADFGVX"

    fun substitute(grid: String, text: String): String {
        val sb = StringBuilder()
        for (c in text) {
            val at = grid.indexOf(c)
            if (at >= 0) sb.append(SYMBOLS[at / 6]).append(SYMBOLS[at % 6])
        }
        return sb.toString()
    }

    fun unsubstitute(grid: String, symbols: String): String {
        val sb = StringBuilder()
        var i = 0
        while (i + 1 < symbols.length) {
            val row = SYMBOLS.indexOf(symbols[i])
            val col = SYMBOLS.indexOf(symbols[i + 1])
            if (row >= 0 && col >= 0) sb.append(grid[row * 6 + col])
            i += 2
        }
        return sb.toString()
    }
}
