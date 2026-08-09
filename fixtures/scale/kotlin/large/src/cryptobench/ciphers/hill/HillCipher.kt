package cryptobench.ciphers.hill

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** 2x2 matrix cipher over pairs of letters mod 26. */
class HillCipher(private val key: HillKey) : Cipher {

    override fun name(): String = "hill"

    override fun encrypt(plaintext: String): String = apply(Alphabet.clean(plaintext), key.matrix())

    override fun decrypt(ciphertext: String): String = apply(Alphabet.clean(ciphertext), key.inverseMatrix())

    private fun apply(input: String, m: IntArray): String {
        val text = if (input.length % 2 == 0) input else input + "X"
        val sb = StringBuilder()
        var i = 0
        while (i + 1 < text.length) {
            val x = Alphabet.indexOf(text[i])
            val y = Alphabet.indexOf(text[i + 1])
            sb.append(Alphabet.charAt(m[0] * x + m[1] * y))
            sb.append(Alphabet.charAt(m[2] * x + m[3] * y))
            i += 2
        }
        return sb.toString()
    }
}
