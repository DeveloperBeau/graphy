package cryptobench.ciphers.scytale

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Wraps text around a rod of fixed circumference and reads down the rod. */
class ScytaleCipher(key: ScytaleKey) : Cipher {
    private val rows = key.rows

    override fun name(): String = "scytale"

    override fun encrypt(plaintext: String): String {
        val padded = StringBuilder(Alphabet.clean(plaintext))
        while (padded.length % rows != 0) padded.append('X')
        val text = padded.toString()
        val cols = text.length / rows
        val sb = StringBuilder()
        for (c in 0 until cols) {
            for (r in 0 until rows) sb.append(text[r * cols + c])
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val text = Alphabet.clean(ciphertext)
        val cols = text.length / rows
        val sb = StringBuilder()
        for (r in 0 until rows) {
            for (c in 0 until cols) sb.append(text[c * rows + r])
        }
        return sb.toString()
    }
}
