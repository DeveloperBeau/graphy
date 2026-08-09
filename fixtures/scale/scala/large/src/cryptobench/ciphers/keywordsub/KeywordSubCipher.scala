package cryptobench.ciphers.keywordsub

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Monoalphabetic substitution built from a keyword-mixed alphabet. */
final class KeywordSubCipher(key: KeywordSubKey) extends Cipher {
  private val mixed = key.mixedAlphabet

  override def name: String = "keywordsub"

  override def encrypt(plaintext: String): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(plaintext)) {
      sb.append(mixed.charAt(Alphabet.indexOf(c)))
    }
    sb.toString
  }

  override def decrypt(ciphertext: String): String = {
    val sb = new StringBuilder
    for (c <- Alphabet.clean(ciphertext)) {
      sb.append(Alphabet.charAt(mixed.indexOf(c)))
    }
    sb.toString
  }
}
