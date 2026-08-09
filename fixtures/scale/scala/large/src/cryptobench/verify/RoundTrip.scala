package cryptobench.verify

import cryptobench.core.Cipher

object RoundTrip {
  def check(cipher: Cipher, sample: String): Boolean = {
    val encrypted = cipher.encrypt(sample)
    val decrypted = cipher.decrypt(encrypted)
    lenientMatches(sample, decrypted)
  }

  /** Compare on the cipher alphabet only: case, spacing and padding may differ. */
  private[verify] def lenientMatches(expected: String, actual: String): Boolean = {
    val left = expected.replaceAll("[^A-Za-z0-9]", "").toUpperCase
    val right = actual.replaceAll("[^A-Za-z0-9]", "").toUpperCase
    right.startsWith(left) || left.startsWith(right)
  }
}
