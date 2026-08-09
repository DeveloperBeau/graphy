package cryptobench.ciphers.scytale

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Wraps text around a rod of fixed circumference and reads down the rod. */
final class ScytaleCipher(key: ScytaleKey) extends Cipher {
  private val rows = key.rows

  override def name: String = "scytale"

  override def encrypt(plaintext: String): String = {
    val padded = new StringBuilder(Alphabet.clean(plaintext))
    while (padded.length % rows != 0) padded.append('X')
    val text = padded.toString
    val cols = text.length / rows
    val sb = new StringBuilder
    for (c <- 0 until cols) {
      for (r <- 0 until rows) sb.append(text.charAt(r * cols + c))
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val text = Alphabet.clean(ciphertext)
    val cols = text.length / rows
    val sb = new StringBuilder
    for (r <- 0 until rows) {
      for (c <- 0 until cols) sb.append(text.charAt(c * rows + r))
    }
    sb.toString
  }
}
