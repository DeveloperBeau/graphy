package cryptobench.ciphers.xorcipher

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Repeating-key XOR; ciphertext is hex so it stays printable. */
final class XorCipherCipher(key: XorCipherKey) extends Cipher {
  private val keyBytes = Bytes.of(key.phrase)

  override def name: String = "xorcipher"

  override def encrypt(plaintext: String): String = Hex.encode(mask(Bytes.of(plaintext)))

  override def decrypt(ciphertext: String): String = Bytes.toText(mask(Hex.decode(ciphertext)))

  private def mask(data: Array[Byte]): Array[Byte] =
    Array.tabulate(data.length)(i => (data(i) ^ keyBytes(i % keyBytes.length)).toByte)
}
