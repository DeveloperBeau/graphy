package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Caesar with a fixed shift of 13, so encryption is its own inverse. */
class Rot13Cipher(private val key: Rot13Key) : Cipher {

    override fun name(): String = "rot13"

    override fun encrypt(plaintext: String): String = shiftBy(plaintext, 13 * key.rounds)

    override fun decrypt(ciphertext: String): String = shiftBy(ciphertext, -(13 * key.rounds))

    private fun shiftBy(text: String, amount: Int): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(text)) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount))
        }
        return sb.toString()
    }
}
