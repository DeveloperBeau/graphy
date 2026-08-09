package cryptobench.ciphers.vigenere

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Adds the repeating keyword letter to each plaintext letter. */
class VigenereCipher(private val key: VigenereKey) : Cipher {

    override fun name(): String = "vigenere"

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
