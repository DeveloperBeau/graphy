package cryptobench.ciphers.columnar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

class ColumnarCipher(private val key: ColumnarKey) : Cipher {
    private val order = key.columnOrder()

    override fun name(): String = "columnar"

    /** Write in rows, read the columns in keyword order. */
    override fun encrypt(plaintext: String): String {
        val text = key.padded(Alphabet.clean(plaintext))
        val sb = StringBuilder()
        for (col in order) {
            var row = 0
            while (row * order.size + col < text.length) {
                sb.append(text[row * order.size + col])
                row++
            }
        }
        return sb.toString()
    }

    override fun decrypt(ciphertext: String): String {
        val text = Alphabet.clean(ciphertext)
        val rows = text.length / order.size
        val out = CharArray(text.length)
        var cursor = 0
        for (col in order) {
            for (row in 0 until rows) {
                out[row * order.size + col] = text[cursor++]
            }
        }
        return String(out)
    }
}
