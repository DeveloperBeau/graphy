package cryptobench.ciphers.autokey

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** The key stream is the primer followed by the plaintext itself. */
final class AutokeyCipher(key: AutokeyKey) extends Cipher {

  override def name: String = "autokey"

  override def encrypt(plaintext: String): String = {
    val text = Alphabet.clean(plaintext)
    val stream = key.primer + text
    val sb = new StringBuilder
    for (i <- text.indices) {
      sb.append(Alphabet.charAt(Alphabet.indexOf(text.charAt(i)) + Alphabet.indexOf(stream.charAt(i))))
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val text = Alphabet.clean(ciphertext)
    val stream = new StringBuilder(key.primer)
    val sb = new StringBuilder
    for (i <- text.indices) {
      val plain = Alphabet.charAt(Alphabet.indexOf(text.charAt(i)) - Alphabet.indexOf(stream.charAt(i)))
      sb.append(plain)
      stream.append(plain)
    }
    sb.toString
  }
}
