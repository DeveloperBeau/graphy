package cryptobench.ciphers.ctr

import cryptobench.ciphers.feistel.FeistelKey
import cryptobench.ciphers.feistel.FeistelNetwork
import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

/** Counter mode: encrypt a counter stream, xor it with the data. */
final class CtrModeCipher(key: CtrModeKey) extends Cipher {
  private val network = new FeistelNetwork(FeistelKey(key.blockKey))

  override def name: String = "ctr"

  override def encrypt(plaintext: String): String =
    Hex.encode(CtrKeystream.mask(network, key.nonce, Bytes.of(plaintext)))

  override def decrypt(ciphertext: String): String =
    Bytes.toText(CtrKeystream.mask(network, key.nonce, Hex.decode(ciphertext)))
}
