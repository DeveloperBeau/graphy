package cryptobench.ciphers.playfair

/** The three Playfair digraph rules: same row, same column, rectangle. */
internal object PlayfairRules {
    fun transform(square: String, pairs: String, step: Int): String {
        val sb = StringBuilder()
        var i = 0
        while (i + 1 < pairs.length) {
            val a = square.indexOf(pairs[i])
            val b = square.indexOf(pairs[i + 1])
            when {
                a / 5 == b / 5 -> {
                    sb.append(square[a / 5 * 5 + (a + step) % 5])
                    sb.append(square[b / 5 * 5 + (b + step) % 5])
                }
                a % 5 == b % 5 -> {
                    sb.append(square[(a + step * 5) % 25 / 5 * 5 + a % 5])
                    sb.append(square[(b + step * 5) % 25 / 5 * 5 + b % 5])
                }
                else -> {
                    sb.append(square[a / 5 * 5 + b % 5])
                    sb.append(square[b / 5 * 5 + a % 5])
                }
            }
            i += 2
        }
        return sb.toString()
    }
}
