package cryptobench.ciphers.tea

import cryptobench.core.Cipher
import cryptobench.util.BlockCodec
import cryptobench.util.Bytes
import cryptobench.util.Hex

class TeaCipher(private val key: TeaKey) : Cipher {

    override fun name(): String = "tea"

    override fun encrypt(plaintext: String): String {
        val data = Bytes.pad(Bytes.of(plaintext), 8)
        var off = 0
        while (off < data.size) {
            BlockCodec.write(data, off, TeaRounds.encryptBlock(BlockCodec.read(data, off), key))
            off += 8
        }
        return Hex.encode(data)
    }

    override fun decrypt(ciphertext: String): String {
        val data = Hex.decode(ciphertext)
        var off = 0
        while (off < data.size) {
            BlockCodec.write(data, off, TeaRounds.decryptBlock(BlockCodec.read(data, off), key))
            off += 8
        }
        return Bytes.toText(data).trim { it <= ' ' }
    }
}
