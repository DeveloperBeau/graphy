package cryptobench.ciphers.myszkowski

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/**
 * Myszkowski transposition with a repeated-letter keyword. Equal letters read
 * left to right, realised here by delegating to a plain columnar pass over
 * the tie-broken column order.
 */
final class MyszkowskiCipher(key: MyszkowskiKey) extends Cipher {
  private val delegate = new ColumnarCipher(ColumnarKey(key.keyword))

  override def name: String = "myszkowski"

  override def encrypt(plaintext: String): String = delegate.encrypt(plaintext)

  override def decrypt(ciphertext: String): String = delegate.decrypt(ciphertext)
}
