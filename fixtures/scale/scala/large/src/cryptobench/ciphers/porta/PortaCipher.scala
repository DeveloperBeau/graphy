package cryptobench.ciphers.porta

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal cipher over half-alphabets selected by the key letter. */
final class PortaCipher(key: PortaKey) extends Cipher {

  override def name: String = "porta"

  override def encrypt(plaintext: String): String = swapHalves(Alphabet.clean(plaintext))

  override def decrypt(ciphertext: String): String = swapHalves(Alphabet.clean(ciphertext))

  private def swapHalves(text: String): String = {
    val sb = new StringBuilder
    for (i <- text.indices) {
      val x = Alphabet.indexOf(text.charAt(i))
      val row = Alphabet.indexOf(key.keyCharAt(i)) / 2
      val y = if (x < 13) 13 + Math.floorMod(x + row, 13) else Math.floorMod(x - 13 - row, 13)
      sb.append(Alphabet.charAt(y))
    }
    sb.toString
  }
}
