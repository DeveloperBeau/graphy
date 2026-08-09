package cryptobench.ciphers.adfgvx;

import cryptobench.ciphers.columnar.ColumnarCipher;
import cryptobench.ciphers.columnar.ColumnarKey;
import cryptobench.core.Cipher;

/** Field cipher: substitution into ADFGVX symbols, then columnar transposition. */
public class AdfgvxCipher implements Cipher {
    private final AdfgvxKey key;
    private final ColumnarCipher transposition;

    public AdfgvxCipher(AdfgvxKey key) {
        this.key = key;
        this.transposition = new ColumnarCipher(new ColumnarKey(key.getTranspositionWord()));
    }

    @Override
    public String name() { return "adfgvx"; }

    @Override
    public String encrypt(String plaintext) {
        String cleaned = plaintext.toUpperCase().replaceAll("[^A-Z0-9]", "");
        return transposition.encrypt(AdfgvxSymbols.substitute(key.grid(), cleaned));
    }

    @Override
    public String decrypt(String ciphertext) {
        return AdfgvxSymbols.unsubstitute(key.grid(), transposition.decrypt(ciphertext));
    }
}
