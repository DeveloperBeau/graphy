package cryptobench.ciphers.foursquare

import cryptobench.ciphers.playfair.PlayfairDigraphs
import cryptobench.ciphers.playfair.PlayfairKey
import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Plain squares on one diagonal, keyword squares on the other. */
final class FourSquareCipher(key: FourSquareKey) extends Cipher {
  private val plain = PlayfairKey("").square

  override def name: String = "foursquare"

  override def encrypt(plaintext: String): String = {
    val pairs = PlayfairDigraphs.split(Alphabet.clean(plaintext))
    val sb = new StringBuilder
    for (i <- 0 until pairs.length - 1 by 2) {
      val a = plain.indexOf(pairs.charAt(i))
      val b = plain.indexOf(pairs.charAt(i + 1))
      sb.append(key.upperSquare.charAt(a / 5 * 5 + b % 5)).append(key.lowerSquare.charAt(b / 5 * 5 + a % 5))
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val pairs = Alphabet.clean(ciphertext)
    val sb = new StringBuilder
    for (i <- 0 until pairs.length - 1 by 2) {
      val a = key.upperSquare.indexOf(pairs.charAt(i))
      val b = key.lowerSquare.indexOf(pairs.charAt(i + 1))
      sb.append(plain.charAt(a / 5 * 5 + b % 5)).append(plain.charAt(b / 5 * 5 + a % 5))
    }
    sb.toString
  }
}
