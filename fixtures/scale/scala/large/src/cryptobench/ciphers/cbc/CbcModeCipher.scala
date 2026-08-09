package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Cipher block chaining over the Feistel block, with a fixed IV from the key. */
final class CbcModeCipher(key: CbcModeKey) extends Cipher {
  private val network = new FeistelNetwork(FeistelKey(key.blockKey))

  override def name: String = "cbc"

  override def encrypt(plaintext: String): String = {
    val data = Bytes.pad(Bytes.of(plaintext), 8)
    CbcChain.encrypt(network, data, key.iv)
    Hex.encode(data)
  }

  override def decrypt(ciphertext: String): String = {
    val data = Hex.decode(ciphertext)
    CbcChain.decrypt(network, data, key.iv)
    Bytes.toText(data).trim
  }
}
