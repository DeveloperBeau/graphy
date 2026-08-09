package cryptobench.ciphers.lcg

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Keystream from a linear congruential generator seeded by the key. */
final class LcgCipher(key: LcgKey) extends Cipher {

  override def name: String = "lcg"

  override def encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

  override def decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

  private def mask(data: Array[Byte]): Array[Byte] = {
    var state = key.seed
    val out = new Array[Byte](data.length)
    for (i <- data.indices) {
      state = state * 6364136223846793005L + 1442695040888963407L
      out(i) = (data(i) ^ (state >>> 16).toByte).toByte
    }
    out
  }
}
