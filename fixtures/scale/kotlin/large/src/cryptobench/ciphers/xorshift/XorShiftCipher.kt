package cryptobench.ciphers.xorshift

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a xorshift64 generator seeded by the key. */
class XorShiftCipher(private val key: XorShiftKey) : Cipher {

    override fun name(): String = "xorshift"

    override fun encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

    override fun decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

    private fun mask(data: ByteArray): ByteArray {
        var state = key.seed
        val out = ByteArray(data.size)
        for (i in data.indices) {
            state = state xor (state shl 13); state = state xor (state ushr 7); state = state xor (state shl 17)
            out[i] = (data[i].toInt() xor (state ushr 16).toInt()).toByte()
        }
        return out
    }
}
