package cryptobench.ciphers.caesar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Classic shift cipher; the key is the fixed shift amount. */
final class CaesarCipher(key: CaesarKey) extends Cipher {

  override def name: String = "caesar"

  override def encrypt(plaintext: String): String = shiftBy(plaintext, key.shift)

  override def decrypt(ciphertext: String): String = shiftBy(ciphertext, -(key.shift))

  private def shiftBy(text: String, amount: Int): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(text)) {
      sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount))
    }
    sb.toString
  }
}
