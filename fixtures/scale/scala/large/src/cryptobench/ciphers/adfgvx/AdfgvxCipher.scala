package cryptobench.ciphers.adfgvx

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/** Field cipher: substitution into ADFGVX symbols, then columnar transposition. */
final class AdfgvxCipher(key: AdfgvxKey) extends Cipher {
  private val transposition = new ColumnarCipher(ColumnarKey(key.transpositionWord))

  override def name: String = "adfgvx"

  override def encrypt(plaintext: String): String = {
    val cleaned = plaintext.toUpperCase.replaceAll("[^A-Z0-9]", "")
    transposition.encrypt(AdfgvxSymbols.substitute(key.grid, cleaned))
  }

  override def decrypt(ciphertext: String): String =
    AdfgvxSymbols.unsubstitute(key.grid, transposition.decrypt(ciphertext))
}
