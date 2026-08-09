package cryptobench.ciphers.bifid

import cryptobench.ciphers.polybius.PolybiusCipher
import cryptobench.ciphers.polybius.PolybiusKey
import cryptobench.core.Cipher

/** Polybius coordinates split into rows, recombined after transposition. */
final class BifidCipher(key: BifidKey) extends Cipher {
  private val coordinates = new PolybiusCipher(PolybiusKey(key.seedWord))

  override def name: String = "bifid"

  override def encrypt(plaintext: String): String = {
    val digits = coordinates.encrypt(plaintext)
    val rows = new StringBuilder
    val cols = new StringBuilder
    var i = 0
    while (i + 1 < digits.length) {
      rows.append(digits.charAt(i))
      cols.append(digits.charAt(i + 1))
      i += 2
    }
    coordinates.decrypt(rows.toString + cols.toString)
  }

  override def decrypt(ciphertext: String): String = {
    val digits = coordinates.encrypt(ciphertext)
    val half = digits.length / 2
    val sb = new StringBuilder
    for (i <- 0 until half) {
      sb.append(digits.charAt(i)).append(digits.charAt(half + i))
    }
    coordinates.decrypt(sb.toString)
  }
}
