package cryptobench.ciphers.xorshift

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a xorshift64 generator seeded by the key. */
final class XorShiftCipher(key: XorShiftKey) extends Cipher {

  override def name: String = "xorshift"

  override def encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

  override def decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

  private def mask(data: Array[Byte]): Array[Byte] = {
    var state = key.seed
    val out = new Array[Byte](data.length)
    for (i <- data.indices) {
      state ^= (state << 13); state ^= (state >>> 7); state ^= (state << 17)
      out(i) = (data(i) ^ (state >>> 16).toByte).toByte
    }
    out
  }
}
