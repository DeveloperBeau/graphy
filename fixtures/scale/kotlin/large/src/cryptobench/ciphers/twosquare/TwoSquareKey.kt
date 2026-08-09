package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairKey

data class TwoSquareKey(val topWord: String, val bottomWord: String) {

    fun topSquare(): String = PlayfairKey(topWord).square()

    fun bottomSquare(): String = PlayfairKey(bottomWord).square()

    companion object {
        fun default(): TwoSquareKey = TwoSquareKey("EXAMPLE", "KEYWORD")
    }
}
