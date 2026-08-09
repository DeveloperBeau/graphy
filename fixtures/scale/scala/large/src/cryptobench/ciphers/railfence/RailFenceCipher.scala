package cryptobench.ciphers.railfence

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes the text in a zigzag across rails, then reads rail by rail. */
final class RailFenceCipher(key: RailFenceKey) extends Cipher {
  private val pattern = new RailPattern(key.rails)

  override def name: String = "railfence"

  override def encrypt(plaintext: String): String = {
    val text = Alphabet.clean(plaintext)
    val rows = Array.fill(pattern.railCount)(new StringBuilder)
    for (i <- text.indices) rows(pattern.railFor(i)).append(text.charAt(i))
    rows.mkString
  }

  override def decrypt(ciphertext: String): String = {
    val text = Alphabet.clean(ciphertext)
    val out = new Array[Char](text.length)
    var cursor = 0
    for (r <- 0 until pattern.railCount) {
      for (i <- text.indices) {
        if (pattern.railFor(i) == r) { out(i) = text.charAt(cursor); cursor += 1 }
      }
    }
    new String(out)
  }
}
