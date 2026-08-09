package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Caesar with a fixed shift of 13, so encryption is its own inverse. */
final class Rot13Cipher(key: Rot13Key) extends Cipher {

  override def name: String = "rot13"

  override def encrypt(plaintext: String): String = shiftBy(plaintext, 13 * key.rounds)

  override def decrypt(ciphertext: String): String = shiftBy(ciphertext, -(13 * key.rounds))

  private def shiftBy(text: String, amount: Int): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(text)) {
      sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount))
    }
    sb.toString
  }
}
