package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairDigraphs
import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraphs looked up across two keyword squares stacked vertically. */
final class TwoSquareCipher(key: TwoSquareKey) extends Cipher {
  private val top = key.topSquare
  private val bottom = key.bottomSquare

  override def name: String = "twosquare"

  override def encrypt(plaintext: String): String = swap(PlayfairDigraphs.split(Alphabet.clean(plaintext)))

  override def decrypt(ciphertext: String): String = swap(PlayfairDigraphs.split(Alphabet.clean(ciphertext)))

  private def swap(pairs: String): String = {
    val sb = new StringBuilder
    var i = 0
    while (i + 1 < pairs.length) {
      val a = top.indexOf(pairs.charAt(i))
      val b = bottom.indexOf(pairs.charAt(i + 1))
      sb.append(top.charAt(a / 5 * 5 + b % 5)).append(bottom.charAt(b / 5 * 5 + a % 5))
      i += 2
    }
    sb.toString
  }
}
