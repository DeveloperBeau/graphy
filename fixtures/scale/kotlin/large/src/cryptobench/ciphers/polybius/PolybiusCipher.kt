package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Encodes each letter as its row/column pair in a 5x5 square (J folds into I). */
class PolybiusCipher(key: PolybiusKey) : Cipher {
    private val square = key.square()

    override fun name(): String = "polybius"

    override fun encrypt(plaintext: String): String {
        val sb = StringBuilder()
        for (c in Alphabet.clean(plaintext).replace('J', 'I')) {
            val at = square.indexOf(c)
            sb.append('1' + at / 5).append('1' + at % 5)
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val sb = StringBuilder()
        var i = 0
        while (i + 1 < ciphertext.length) {
            val row = ciphertext[i] - '1'
            val col = ciphertext[i + 1] - '1'
            sb.append(square[row * 5 + col])
            i += 2
        }
        return sb.toString()
    }
}
