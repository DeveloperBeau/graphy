package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes rows left to right, reads them back boustrophedon (snake order). */
final class RouteCipher(key: RouteKey) extends Cipher {
  private val width = key.width

  override def name: String = "route"

  override def encrypt(plaintext: String): String = {
    val padded = new StringBuilder(Alphabet.clean(plaintext))
    while (padded.length % width != 0) padded.append('X')
    snake(padded.toString)
  }

  override def decrypt(ciphertext: String): String = snake(Alphabet.clean(ciphertext))

  /** Reversing alternate rows is its own inverse, so both directions share it. */
  private def snake(text: String): String = {
    val sb = new StringBuilder
    var row = 0
    while (row * width < text.length) {
      val slice = text.substring(row * width, math.min(row * width + width, text.length))
      sb.append(if (row % 2 == 0) slice else slice.reverse)
      row += 1
    }
    sb.toString
  }
}
