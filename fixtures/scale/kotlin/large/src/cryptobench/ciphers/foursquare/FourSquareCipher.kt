package cryptobench.ciphers.foursquare

import cryptobench.ciphers.playfair.PlayfairDigraphs
import cryptobench.ciphers.playfair.PlayfairKey
import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Plain squares on one diagonal, keyword squares on the other. */
class FourSquareCipher(private val key: FourSquareKey) : Cipher {

    override fun name(): String = "foursquare"

    override fun encrypt(plaintext: String): String {
        val pairs = PlayfairDigraphs.split(Alphabet.clean(plaintext))
        val sb = StringBuilder()
        for (i in 0 until pairs.length - 1 step 2) {
            val a = PLAIN.indexOf(pairs[i])
            val b = PLAIN.indexOf(pairs[i + 1])
            sb.append(key.upperSquare()[a / 5 * 5 + b % 5]).append(key.lowerSquare()[b / 5 * 5 + a % 5])
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val pairs = Alphabet.clean(ciphertext)
        val sb = StringBuilder()
        for (i in 0 until pairs.length - 1 step 2) {
            val a = key.upperSquare().indexOf(pairs[i])
            val b = key.lowerSquare().indexOf(pairs[i + 1])
            sb.append(PLAIN[a / 5 * 5 + b % 5]).append(PLAIN[b / 5 * 5 + a % 5])
        }
        return sb.toString()
    }

    companion object {
        private val PLAIN = PlayfairKey("").square()
    }
}
