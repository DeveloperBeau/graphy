package cryptobench.ciphers.ecb

import cryptobench.ciphers.feistel.FeistelCipher
import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.core.Cipher

/** Electronic codebook: each block enciphered independently. */
class EcbModeCipher(key: EcbModeKey) : Cipher {
    private val block = FeistelCipher(FeistelKey(key.blockKey))

    override fun name(): String = "ecb"

    override fun encrypt(plaintext: String): String = block.encrypt(plaintext)

    override fun decrypt(ciphertext: String): String = block.decrypt(ciphertext)
}
