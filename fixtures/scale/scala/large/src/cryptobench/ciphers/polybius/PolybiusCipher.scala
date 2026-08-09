package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Encodes each letter as its row/column pair in a 5x5 square (J folds into I). */
final class PolybiusCipher(key: PolybiusKey) extends Cipher {
  private val square = key.square

  override def name: String = "polybius"

  override def encrypt(plaintext: String): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(plaintext).replace('J', 'I')) {
      val at = square.indexOf(c)
      sb.append(('1' + at / 5).toChar).append(('1' + at % 5).toChar)
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val sb = new StringBuilder
    var i = 0
    while (i + 1 < ciphertext.length) {
      val row = ciphertext.charAt(i) - '1'
      val col = ciphertext.charAt(i + 1) - '1'
      sb.append(square.charAt(row * 5 + col))
      i += 2
    }
    sb.toString
  }
}
