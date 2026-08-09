package cryptobench.ciphers.runningkey

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Vigenere with a long passage as the key stream instead of a short word. */
final class RunningKeyCipher(key: RunningKeyKey) extends Cipher {

  override def name: String = "runningkey"

  override def encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), forward = true)

  override def decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), forward = false)

  private def transform(text: String, forward: Boolean): String = {
    val sb = new StringBuilder
    for (i <- text.indices) {
      val x = Alphabet.indexOf(text.charAt(i))
      val k = Alphabet.indexOf(key.keyCharAt(i))
      sb.append(Alphabet.charAt(if (forward) x + k else x - k))
    }
    sb.toString
  }
}
