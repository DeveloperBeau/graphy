package cryptobench.ciphers.foursquare

import cryptobench.ciphers.playfair.PlayfairKey

data class FourSquareKey(val upperWord: String, val lowerWord: String) {

    fun upperSquare(): String = PlayfairKey(upperWord).square()

    fun lowerSquare(): String = PlayfairKey(lowerWord).square()

    companion object {
        fun default(): FourSquareKey = FourSquareKey("WINTER", "SUMMER")
    }
}
