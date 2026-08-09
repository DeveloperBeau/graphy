package cryptobench.ciphers.adfgvx

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/** Field cipher: substitution into ADFGVX symbols, then columnar transposition. */
class AdfgvxCipher(private val key: AdfgvxKey) : Cipher {
    private val transposition = ColumnarCipher(ColumnarKey(key.transpositionWord))

    override fun name(): String = "adfgvx"

    override fun encrypt(plaintext: String): String {
        val cleaned = plaintext.uppercase().replace(Regex("[^A-Z0-9]"), "")
        return transposition.encrypt(AdfgvxSymbols.substitute(key.grid(), cleaned))
    }

    override fun decrypt(ciphertext: String): String =
        AdfgvxSymbols.unsubstitute(key.grid(), transposition.decrypt(ciphertext))
}
