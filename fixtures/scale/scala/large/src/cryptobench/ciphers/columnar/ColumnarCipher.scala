package cryptobench.ciphers.columnar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

final class ColumnarCipher(key: ColumnarKey) extends Cipher {
  private val order = key.columnOrder

  override def name: String = "columnar"

  /** Write in rows, read the columns in keyword order. */
  override def encrypt(plaintext: String): String = {
    val text = key.padded(Alphabet.clean(plaintext))
    val sb = new StringBuilder
    for (col <- order) {
      var row = 0
      while (row * order.length + col < text.length) {
        sb.append(text.charAt(row * order.length + col))
        row += 1
      }
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val text = Alphabet.clean(ciphertext)
    val rows = text.length / order.length
    val out = new Array[Char](text.length)
    var cursor = 0
    for (col <- order) {
      for (row <- 0 until rows) {
        out(row * order.length + col) = text.charAt(cursor)
        cursor += 1
      }
    }
    new String(out)
  }
}
