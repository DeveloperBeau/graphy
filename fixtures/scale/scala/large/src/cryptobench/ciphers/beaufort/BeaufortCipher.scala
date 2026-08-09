package cryptobench.ciphers.beaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal variant: ciphertext is key letter minus plaintext letter. */
final class BeaufortCipher(key: BeaufortKey) extends Cipher {

  override def name: String = "beaufort"

  override def encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), forward = true)

  override def decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), forward = false)

  private def transform(text: String, forward: Boolean): String = {
    val sb = new StringBuilder
    for (i <- text.indices) {
      val x = Alphabet.indexOf(text.charAt(i))
      val k = Alphabet.indexOf(key.keyCharAt(i))
      sb.append(Alphabet.charAt(if (forward) k - x else k - x))
    }
    sb.toString
  }
}
