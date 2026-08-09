package cryptobench.ciphers.xorcipher

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Repeating-key XOR; ciphertext is hex so it stays printable. */
class XorCipherCipher(key: XorCipherKey) : Cipher {
    private val keyBytes = Bytes.of(key.phrase)

    override fun name(): String = "xorcipher"

    override fun encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

    override fun decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

    private fun mask(data: ByteArray): ByteArray =
        ByteArray(data.size) { i ->
            (data[i].toInt() xor keyBytes[i % keyBytes.size].toInt()).toByte()
        }
}
