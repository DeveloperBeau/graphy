package cryptobench.ciphers.lcg

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a linear congruential generator seeded by the key. */
class LcgCipher(private val key: LcgKey) : Cipher {

    override fun name(): String = "lcg"

    override fun encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

    override fun decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

    private fun mask(data: ByteArray): ByteArray {
        var state = key.seed
        val out = ByteArray(data.size)
        for (i in data.indices) {
            state = state * 6364136223846793005L + 1442695040888963407L
            out[i] = (data[i].toInt() xor (state ushr 16).toInt()).toByte()
        }
        return out
    }
}
