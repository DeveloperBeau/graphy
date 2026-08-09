package cryptobench.ciphers.runningkey

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Vigenere with a long passage as the key stream instead of a short word. */
class RunningKeyCipher(private val key: RunningKeyKey) : Cipher {

    override fun name(): String = "runningkey"

    override fun encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), true)

    override fun decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), false)

    private fun transform(text: String, forward: Boolean): String {
        val sb = StringBuilder()
        for (i in text.indices) {
            val x = Alphabet.indexOf(text[i])
            val k = Alphabet.indexOf(key.keyCharAt(i))
            sb.append(Alphabet.charAt(if (forward) x + k else x - k))
        }
        return sb.toString()
    }
}
