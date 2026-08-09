package cryptobench.ciphers.keywordsub

data class KeywordSubKey(val keyword: String) {

    /** Keyword first (duplicates dropped), then the remaining letters in order. */
    fun mixedAlphabet(): String {
        val sb = StringBuilder()
        for (c in keyword.uppercase() + "ABCDEFGHIJKLMNOPQRSTUVWXYZ") {
            if (c in 'A'..'Z' && !sb.contains(c)) sb.append(c)
        }
        return sb.toString()
    }

    companion object {
        fun default(): KeywordSubKey = KeywordSubKey("OBSIDIAN")
    }
}
