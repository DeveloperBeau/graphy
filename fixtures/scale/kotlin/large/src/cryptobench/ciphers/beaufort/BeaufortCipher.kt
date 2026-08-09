package cryptobench.ciphers.beaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal variant: ciphertext is key letter minus plaintext letter. */
class BeaufortCipher(private val key: BeaufortKey) : Cipher {

    override fun name(): String = "beaufort"

    override fun encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), true)

    override fun decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), false)

    private fun transform(text: String, forward: Boolean): String {
        val sb = StringBuilder()
        for (i in text.indices) {
            val x = Alphabet.indexOf(text[i])
            val k = Alphabet.indexOf(key.keyCharAt(i))
            sb.append(Alphabet.charAt(if (forward) k - x else k - x))
        }
        return sb.toString()
    }
}
