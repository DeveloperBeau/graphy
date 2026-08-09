package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Cipher block chaining over the Feistel block, with a fixed IV from the key. */
class CbcModeCipher(private val key: CbcModeKey) : Cipher {
    private val network = FeistelNetwork(FeistelKey(key.blockKey))

    override fun name(): String = "cbc"

    override fun encrypt(plaintext: String): String {
        val data = Bytes.pad(Bytes.of(plaintext), 8)
        CbcChain.encrypt(network, data, key.iv())
        return Hex.encode(data)
    }

    override fun decrypt(ciphertext: String): String {
        val data = Hex.decode(ciphertext)
        CbcChain.decrypt(network, data, key.iv())
        return Bytes.toText(data).trim { it <= ' ' }
    }
}
