package cryptobench.ciphers.polybius

data class PolybiusKey(val seedWord: String) {

    /** 25-letter square: seed word first, then the rest of the alphabet minus J. */
    fun square(): String {
        val sb = StringBuilder()
        for (c in seedWord.uppercase().replace("J", "I") + "ABCDEFGHIKLMNOPQRSTUVWXYZ") {
            if (c in 'A'..'Z' && c != 'J' && !sb.contains(c)) sb.append(c)
        }
        return sb.toString()
    }

    companion object {
        fun default(): PolybiusKey = PolybiusKey("HARBOR")
    }
}
