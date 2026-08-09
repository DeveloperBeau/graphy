package cryptobench.ciphers.vigenere;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Adds the repeating keyword letter to each plaintext letter. */
public class VigenereCipher implements Cipher {
    private final VigenereKey key;

    public VigenereCipher(VigenereKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "vigenere";
    }

    @Override
    public String encrypt(String plaintext) {
        return transform(Alphabet.clean(plaintext), true);
    }

    @Override
    public String decrypt(String ciphertext) {
        return transform(Alphabet.clean(ciphertext), false);
    }

    private String transform(String text, boolean forward) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            int x = Alphabet.indexOf(text.charAt(i));
            int k = Alphabet.indexOf(key.keyCharAt(i));
            sb.append(Alphabet.charAt(forward ? x + k : x - k));
        }
        return sb.toString();
    }
}
