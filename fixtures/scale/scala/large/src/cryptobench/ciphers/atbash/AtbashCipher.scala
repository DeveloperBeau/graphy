package cryptobench.ciphers.atbash

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Mirrors the alphabet: A maps to Z, B to Y, and so on. */
final class AtbashCipher(@annotation.unused key: AtbashKey) extends Cipher {

  override def name: String = "atbash"

  override def encrypt(plaintext: String): String = mirror(plaintext)

  override def decrypt(ciphertext: String): String = mirror(ciphertext)

  private def mirror(text: String): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(text)) {
      sb.append(Alphabet.charAt(Alphabet.Size - 1 - Alphabet.indexOf(c)))
    }
    sb.toString
  }
}
