package cryptobench.ciphers.affine

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Maps x to (a*x + b) mod 26; a must be coprime with 26. */
final class AffineCipher(key: AffineKey) extends Cipher {

  override def name: String = "affine"

  override def encrypt(plaintext: String): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(plaintext)) {
      sb.append(Alphabet.charAt(key.a * Alphabet.indexOf(c) + key.b))
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val inverse = key.inverseOfA
    val sb = new StringBuilder
    for (c <- Alphabet.clean(ciphertext)) {
      sb.append(Alphabet.charAt(inverse * (Alphabet.indexOf(c) - key.b)))
    }
    sb.toString
  }
}
