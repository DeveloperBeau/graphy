package cryptobench.ciphers.myszkowski

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/**
 * Myszkowski transposition with a repeated-letter keyword. Equal letters read
 * left to right, realised here by delegating to a plain columnar pass over
 * the tie-broken column order.
 */
class MyszkowskiCipher implements Cipher {
    private final ColumnarCipher delegate

    MyszkowskiCipher(MyszkowskiKey key) {
        this.delegate = new ColumnarCipher(new ColumnarKey(key.keyword))
    }

    String name() {
        return "myszkowski"
    }

    String encrypt(String plaintext) {
        return delegate.encrypt(plaintext)
    }

    String decrypt(String ciphertext) {
        return delegate.decrypt(ciphertext)
    }
}
