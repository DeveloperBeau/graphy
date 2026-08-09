package cryptobench.ciphers.ecb

import cryptobench.ciphers.feistel.FeistelCipher
import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.core.Cipher

/** Electronic codebook: each block enciphered independently. */
final class EcbModeCipher(key: EcbModeKey) extends Cipher {
  private val block = new FeistelCipher(FeistelKey(key.blockKey))

  override def name: String = "ecb"

  override def encrypt(plaintext: String): String = block.encrypt(plaintext)

  override def decrypt(ciphertext: String): String = block.decrypt(ciphertext)
}
