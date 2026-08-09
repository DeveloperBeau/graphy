package cryptobench.ciphers.ctr

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Counter mode: encrypt a counter stream, xor it with the data. */
class CtrModeCipher(private val key: CtrModeKey) : Cipher {
    private val network = FeistelNetwork(FeistelKey(key.blockKey))

    override fun name(): String = "ctr"

    override fun encrypt(plaintext: String): String =
        Hex.encode(CtrKeystream.mask(network, key.nonce(), Bytes.of(plaintext)))

    override fun decrypt(ciphertext: String): String =
        Bytes.toText(CtrKeystream.mask(network, key.nonce(), Hex.decode(ciphertext)))
}
