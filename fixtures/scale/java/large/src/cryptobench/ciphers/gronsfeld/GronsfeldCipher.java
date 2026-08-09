package cryptobench.ciphers.gronsfeld;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Vigenere restricted to digit keys: each digit is a shift. */
public class GronsfeldCipher implements Cipher {
    private final GronsfeldKey key;

    public GronsfeldCipher(GronsfeldKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "gronsfeld";
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
            int k = key.digitAt(i);
            sb.append(Alphabet.charAt(forward ? x + k : x - k));
        }
        return sb.toString();
    }
}
