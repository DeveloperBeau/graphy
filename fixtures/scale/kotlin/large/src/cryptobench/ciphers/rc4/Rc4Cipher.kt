package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

class Rc4Cipher(key: Rc4Key) : Cipher {
    private val keyBytes = Bytes.of(key.secret)

    override fun name(): String = "rc4"

    override fun encrypt(plaintext: String): String = Hex.encode(stream(Bytes.of(plaintext)))

    override fun decrypt(ciphertext: String): String = Bytes.toText(stream(Hex.decode(ciphertext)))

    private fun stream(data: ByteArray): ByteArray {
        val s = IntArray(256) { it }
        var j = 0
        for (i in 0 until 256) {
            j = (j + s[i] + (keyBytes[i % keyBytes.size].toInt() and 0xFF)) and 0xFF
            s[i] = s[j].also { s[j] = s[i] }
        }
        val out = ByteArray(data.size)
        var x = 0
        var y = 0
        for (n in data.indices) {
            x = (x + 1) and 0xFF
            y = (y + s[x]) and 0xFF
            s[x] = s[y].also { s[y] = s[x] }
            out[n] = (data[n].toInt() xor s[(s[x] + s[y]) and 0xFF]).toByte()
        }
        return out
    }
}
