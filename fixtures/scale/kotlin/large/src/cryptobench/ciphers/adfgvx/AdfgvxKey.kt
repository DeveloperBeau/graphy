package cryptobench.ciphers.adfgvx

data class AdfgvxKey(val seedWord: String, val transpositionWord: String) {

    /** 36-cell grid of letters and digits, seed word first. */
    fun grid(): String {
        val sb = StringBuilder()
        for (c in seedWord.uppercase() + "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") {
            if (!sb.contains(c)) sb.append(c)
        }
        return sb.toString()
    }

    companion object {
        fun default(): AdfgvxKey = AdfgvxKey("NIGHTMARE", "GERMAN")
    }
}
