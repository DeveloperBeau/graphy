package cryptobench.ciphers.playfair

data class PlayfairKey(val keyword: String) {

    fun square(): String {
        val sb = StringBuilder()
        for (c in keyword.uppercase().replace("J", "I") + "ABCDEFGHIKLMNOPQRSTUVWXYZ") {
            if (c in 'A'..'Z' && c != 'J' && !sb.contains(c)) sb.append(c)
        }
        return sb.toString()
    }

    companion object {
        fun default(): PlayfairKey = PlayfairKey("MONARCHY")
    }
}
