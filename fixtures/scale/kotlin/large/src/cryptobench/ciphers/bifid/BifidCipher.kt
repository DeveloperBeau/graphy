package cryptobench.ciphers.bifid

import cryptobench.ciphers.polybius.PolybiusCipher
import cryptobench.ciphers.polybius.PolybiusKey
import cryptobench.core.Cipher

/** Polybius coordinates split into rows, recombined after transposition. */
class BifidCipher(key: BifidKey) : Cipher {
    private val coordinates = PolybiusCipher(PolybiusKey(key.seedWord))

    override fun name(): String = "bifid"

    override fun encrypt(plaintext: String): String {
        val digits = coordinates.encrypt(plaintext)
        val rows = StringBuilder()
        val cols = StringBuilder()
        var i = 0
        while (i + 1 < digits.length) {
            rows.append(digits[i])
            cols.append(digits[i + 1])
            i += 2
        }
        return coordinates.decrypt(rows.toString() + cols.toString())
    }

    override fun decrypt(ciphertext: String): String {
        val digits = coordinates.encrypt(ciphertext)
        val half = digits.length / 2
        val sb = StringBuilder()
        for (i in 0 until half) {
            sb.append(digits[i]).append(digits[half + i])
        }
        return coordinates.decrypt(sb.toString())
    }
}
