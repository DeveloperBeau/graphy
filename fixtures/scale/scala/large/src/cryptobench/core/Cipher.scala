package cryptobench.core

/**
 * A reversible cipher under test. Implementations normalise their input
 * (usually to the A-Z alphabet) before transforming it, so decrypt(encrypt(x))
 * is compared against the normalised plaintext, not the raw string.
 */
trait Cipher {
  def name: String

  def encrypt(plaintext: String): String

  def decrypt(ciphertext: String): String
}
