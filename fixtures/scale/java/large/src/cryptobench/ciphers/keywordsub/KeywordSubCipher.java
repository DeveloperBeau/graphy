package cryptobench.ciphers.keywordsub;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Monoalphabetic substitution built from a keyword-mixed alphabet. */
public class KeywordSubCipher implements Cipher {
    private final String mixed;

    public KeywordSubCipher(KeywordSubKey key) {
        this.mixed = key.mixedAlphabet();
    }

    @Override
    public String name() {
        return "keywordsub";
    }

    @Override
    public String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(plaintext).toCharArray()) {
            sb.append(mixed.charAt(Alphabet.indexOf(c)));
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(ciphertext).toCharArray()) {
            sb.append(Alphabet.charAt(mixed.indexOf(c)));
        }
        return sb.toString();
    }
}
