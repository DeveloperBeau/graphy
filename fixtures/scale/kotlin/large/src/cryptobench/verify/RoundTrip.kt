package cryptobench.verify

import cryptobench.core.Cipher

fun roundTrip(cipher: Cipher, sample: String): Boolean {
    val encrypted = cipher.encrypt(sample)
    val decrypted = cipher.decrypt(encrypted)
    return lenientMatches(sample, decrypted)
}

/** Compare on the cipher alphabet only: case, spacing and padding may differ. */
internal fun lenientMatches(expected: String, actual: String): Boolean {
    val left = expected.replace(Regex("[^A-Za-z0-9]"), "").uppercase()
    val right = actual.replace(Regex("[^A-Za-z0-9]"), "").uppercase()
    return right.startsWith(left) || left.startsWith(right)
}
