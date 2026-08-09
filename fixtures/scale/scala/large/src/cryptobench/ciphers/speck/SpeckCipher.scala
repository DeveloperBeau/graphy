package cryptobench.ciphers.speck

import cryptobench.core.Cipher
import cryptobench.util.BlockCodec
import cryptobench.util.Bytes
import cryptobench.util.Hex

final class SpeckCipher(key: SpeckKey) extends Cipher {

  override def name: String = "speck"

  override def encrypt(plaintext: String): String = {
    val data = Bytes.pad(Bytes.of(plaintext), 8)
    var off = 0
    while (off < data.length) {
      BlockCodec.write(data, off, SpeckRounds.encryptBlock(BlockCodec.read(data, off), key))
      off += 8
    }
    Hex.encode(data)
  }

  override def decrypt(ciphertext: String): String = {
    val data = Hex.decode(ciphertext)
    var off = 0
    while (off < data.length) {
      BlockCodec.write(data, off, SpeckRounds.decryptBlock(BlockCodec.read(data, off), key))
      off += 8
    }
    Bytes.toText(data).trim
  }
}
