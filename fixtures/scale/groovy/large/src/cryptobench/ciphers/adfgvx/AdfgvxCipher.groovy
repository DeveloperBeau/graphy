package cryptobench.ciphers.adfgvx

import cryptobench.ciphers.columnar.ColumnarCipher
import cryptobench.ciphers.columnar.ColumnarKey
import cryptobench.core.Cipher

/** Field cipher: substitution into ADFGVX symbols, then columnar transposition. */
class AdfgvxCipher implements Cipher {
    private final AdfgvxKey key
    private final ColumnarCipher transposition

    AdfgvxCipher(AdfgvxKey key) {
        this.key = key
        this.transposition = new ColumnarCipher(new ColumnarKey(key.transpositionWord))
    }

    String name() {
        return "adfgvx"
    }

    String encrypt(String plaintext) {
        String cleaned = plaintext.toUpperCase().replaceAll(/[^A-Z0-9]/, "")
        return transposition.encrypt(AdfgvxSymbols.substitute(key.grid(), cleaned))
    }

    String decrypt(String ciphertext) {
        return AdfgvxSymbols.unsubstitute(key.grid(), transposition.decrypt(ciphertext))
    }
}
