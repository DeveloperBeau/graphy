package cryptobench.ciphers.feistel

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

class FeistelCipher(key: FeistelKey) : Cipher {
    private val network = FeistelNetwork(key)

    override fun name(): String = "feistel"

    override fun encrypt(plaintext: String): String {
        val data = Bytes.pad(Bytes.of(plaintext), 8)
        var off = 0
        while (off < data.size) {
            network.block(data, off, false)
            off += 8
        }
        return Hex.encode(data)
    }

    override fun decrypt(ciphertext: String): String {
        val data = Hex.decode(ciphertext)
        var off = 0
        while (off < data.size) {
            network.block(data, off, true)
            off += 8
        }
        return Bytes.toText(data).trim { it <= ' ' }
    }
}
