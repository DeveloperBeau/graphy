package cryptobench.ciphers.feistel

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

final class FeistelCipher(key: FeistelKey) extends Cipher {
  private val network = new FeistelNetwork(key)

  override def name: String = "feistel"

  override def encrypt(plaintext: String): String = {
    val data = Bytes.pad(Bytes.of(plaintext), 8)
    var off = 0
    while (off < data.length) {
      network.block(data, off, reverse = false)
      off += 8
    }
    Hex.encode(data)
  }

  override def decrypt(ciphertext: String): String = {
    val data = Hex.decode(ciphertext)
    var off = 0
    while (off < data.length) {
      network.block(data, off, reverse = true)
      off += 8
    }
    Bytes.toText(data).trim
  }
}
