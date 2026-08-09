package cryptobench.ciphers.variantbeaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Subtracts the keyword letter on encrypt, adds it back on decrypt. */
class VariantBeaufortCipher(private val key: VariantBeaufortKey) : Cipher {

    override fun name(): String = "variantbeaufort"

    override fun encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), true)

    override fun decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), false)

    private fun transform(text: String, forward: Boolean): String {
        val sb = StringBuilder()
        for (i in text.indices) {
            val x = Alphabet.indexOf(text[i])
            val k = Alphabet.indexOf(key.keyCharAt(i))
            sb.append(Alphabet.charAt(if (forward) x - k else x + k))
        }
        return sb.toString()
    }
}
