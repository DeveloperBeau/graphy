package cryptobench.ciphers.simon

import cryptobench.core.Cipher
import cryptobench.util.BlockCodec
import cryptobench.util.Bytes
import cryptobench.util.Hex

class SimonCipher(private val key: SimonKey) : Cipher {

    override fun name(): String = "simon"

    override fun encrypt(plaintext: String): String {
        val data = Bytes.pad(Bytes.of(plaintext), 8)
        var off = 0
        while (off < data.size) {
            BlockCodec.write(data, off, SimonRounds.encryptBlock(BlockCodec.read(data, off), key))
            off += 8
        }
        return Hex.encode(data)
    }

    override fun decrypt(ciphertext: String): String {
        val data = Hex.decode(ciphertext)
        var off = 0
        while (off < data.size) {
            BlockCodec.write(data, off, SimonRounds.decryptBlock(BlockCodec.read(data, off), key))
            off += 8
        }
        return Bytes.toText(data).trim { it <= ' ' }
    }
}
