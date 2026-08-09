package cryptobench.ciphers.playfair

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraph substitution over a 5x5 keyword square. */
final class PlayfairCipher(key: PlayfairKey) extends Cipher {
  private val square = key.square

  override def name: String = "playfair"

  override def encrypt(plaintext: String): String =
    PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(plaintext)), 1)

  override def decrypt(ciphertext: String): String =
    PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(ciphertext)), 4)
}
