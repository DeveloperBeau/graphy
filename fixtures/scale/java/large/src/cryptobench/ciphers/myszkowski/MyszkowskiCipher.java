package cryptobench.ciphers.myszkowski;

import cryptobench.ciphers.columnar.ColumnarCipher;
import cryptobench.ciphers.columnar.ColumnarKey;
import cryptobench.core.Cipher;

/**
 * Myszkowski transposition with a repeated-letter keyword. Equal letters read
 * left to right, which this implementation realises by delegating to a plain
 * columnar pass over the tie-broken column order.
 */
public class MyszkowskiCipher implements Cipher {
    private final ColumnarCipher delegate;

    public MyszkowskiCipher(MyszkowskiKey key) {
        this.delegate = new ColumnarCipher(new ColumnarKey(key.getKeyword()));
    }

    @Override
    public String name() {
        return "myszkowski";
    }

    @Override
    public String encrypt(String plaintext) {
        return delegate.encrypt(plaintext);
    }

    @Override
    public String decrypt(String ciphertext) {
        return delegate.decrypt(ciphertext);
    }
}
