package cryptobench.ciphers.affine;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Maps x to (a*x + b) mod 26; a must be coprime with 26. */
public class AffineCipher implements Cipher {
    private final AffineKey key;

    public AffineCipher(AffineKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "affine";
    }

    @Override
    public String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(plaintext).toCharArray()) {
            sb.append(Alphabet.charAt(key.getA() * Alphabet.indexOf(c) + key.getB()));
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        int inverse = key.inverseOfA();
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(ciphertext).toCharArray()) {
            sb.append(Alphabet.charAt(inverse * (Alphabet.indexOf(c) - key.getB())));
        }
        return sb.toString();
    }
}
