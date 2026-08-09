package cryptobench.ciphers.hill

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** 2x2 matrix cipher over pairs of letters mod 26. */
final class HillCipher(key: HillKey) extends Cipher {

  override def name: String = "hill"

  override def encrypt(plaintext: String): String = apply(Alphabet.clean(plaintext), key.matrix)

  override def decrypt(ciphertext: String): String = apply(Alphabet.clean(ciphertext), key.inverseMatrix)

  private def apply(input: String, m: Array[Int]): String = {
    val text = if (input.length % 2 == 0) input else input + "X"
    val sb = new StringBuilder
    var i = 0
    while (i + 1 < text.length) {
      val x = Alphabet.indexOf(text.charAt(i))
      val y = Alphabet.indexOf(text.charAt(i + 1))
      sb.append(Alphabet.charAt(m(0) * x + m(1) * y))
      sb.append(Alphabet.charAt(m(2) * x + m(3) * y))
      i += 2
    }
    sb.toString
  }
}
