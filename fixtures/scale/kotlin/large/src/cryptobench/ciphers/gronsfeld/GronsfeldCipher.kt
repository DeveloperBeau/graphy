package cryptobench.ciphers.gronsfeld

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Vigenere restricted to digit keys: each digit is a shift. */
class GronsfeldCipher(private val key: GronsfeldKey) : Cipher {

    override fun name(): String = "gronsfeld"

    override fun encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), true)

    override fun decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), false)

    private fun transform(text: String, forward: Boolean): String {
        val sb = StringBuilder()
        for (i in text.indices) {
            val x = Alphabet.indexOf(text[i])
            val k = key.digitAt(i)
            sb.append(Alphabet.charAt(if (forward) x + k else x - k))
        }
        return sb.toString()
    }
}
