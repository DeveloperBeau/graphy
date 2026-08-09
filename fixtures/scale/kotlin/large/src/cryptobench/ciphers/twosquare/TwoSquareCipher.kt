package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairDigraphs
import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraphs looked up across two keyword squares stacked vertically. */
class TwoSquareCipher(key: TwoSquareKey) : Cipher {
    private val top = key.topSquare()
    private val bottom = key.bottomSquare()

    override fun name(): String = "twosquare"

    override fun encrypt(plaintext: String): String = swap(PlayfairDigraphs.split(Alphabet.clean(plaintext)))

    override fun decrypt(ciphertext: String): String = swap(PlayfairDigraphs.split(Alphabet.clean(ciphertext)))

    private fun swap(pairs: String): String {
        val sb = StringBuilder()
        var i = 0
        while (i + 1 < pairs.length) {
            val a = top.indexOf(pairs[i])
            val b = bottom.indexOf(pairs[i + 1])
            sb.append(top[a / 5 * 5 + b % 5]).append(bottom[b / 5 * 5 + a % 5])
            i += 2
        }
        return sb.toString()
    }
}
