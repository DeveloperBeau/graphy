package cryptobench.ciphers.gronsfeld

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Vigenere restricted to digit keys: each digit is a shift. */
final class GronsfeldCipher(key: GronsfeldKey) extends Cipher {

  override def name: String = "gronsfeld"

  override def encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), forward = true)

  override def decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), forward = false)

  private def transform(text: String, forward: Boolean): String = {
    val sb = new StringBuilder
    for (i <- text.indices) {
      val x = Alphabet.indexOf(text.charAt(i))
      val k = key.digitAt(i)
      sb.append(Alphabet.charAt(if (forward) x + k else x - k))
    }
    sb.toString
  }
}
