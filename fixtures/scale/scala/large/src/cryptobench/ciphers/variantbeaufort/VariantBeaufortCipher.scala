package cryptobench.ciphers.variantbeaufort

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Subtracts the keyword letter on encrypt, adds it back on decrypt. */
final class VariantBeaufortCipher(key: VariantBeaufortKey) extends Cipher {

  override def name: String = "variantbeaufort"

  override def encrypt(plaintext: String): String = transform(Alphabet.clean(plaintext), forward = true)

  override def decrypt(ciphertext: String): String = transform(Alphabet.clean(ciphertext), forward = false)

  private def transform(text: String, forward: Boolean): String = {
    val sb = new StringBuilder
    for (i <- text.indices) {
      val x = Alphabet.indexOf(text.charAt(i))
      val k = Alphabet.indexOf(key.keyCharAt(i))
      sb.append(Alphabet.charAt(if (forward) x - k else x + k))
    }
    sb.toString
  }
}
