package cryptobench.ciphers.caesar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Classic shift cipher; the key is the fixed shift amount. */
class CaesarCipher(private val key: CaesarKey) : Cipher {

    override fun name(): String = "caesar"

    override fun encrypt(plaintext: String): String = shiftBy(plaintext, key.shift)

    override fun decrypt(ciphertext: String): String = shiftBy(ciphertext, -(key.shift))

    private fun shiftBy(text: String, amount: Int): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(text)) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount))
        }
        return sb.toString()
    }
}
