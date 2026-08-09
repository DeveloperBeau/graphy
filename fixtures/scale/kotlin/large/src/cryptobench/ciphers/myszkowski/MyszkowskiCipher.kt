package cryptobench.ciphers.myszkowski

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/**
 * Myszkowski transposition with a repeated-letter keyword. Equal letters read
 * left to right, realised here by delegating to a plain columnar pass over
 * the tie-broken column order.
 */
class MyszkowskiCipher(key: MyszkowskiKey) : Cipher {
    private val delegate = ColumnarCipher(ColumnarKey(key.keyword))

    override fun name(): String = "myszkowski"

    override fun encrypt(plaintext: String): String = delegate.encrypt(plaintext)

    override fun decrypt(ciphertext: String): String = delegate.decrypt(ciphertext)
}
