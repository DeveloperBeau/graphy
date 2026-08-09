package cryptobench.ciphers.caesar;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Classic shift cipher; the key is the fixed shift amount. */
public class CaesarCipher implements Cipher {
    private final CaesarKey key;

    public CaesarCipher(CaesarKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "caesar";
    }

    @Override
    public String encrypt(String plaintext) {
        return shiftBy(plaintext, key.getShift());
    }

    @Override
    public String decrypt(String ciphertext) {
        return shiftBy(ciphertext, -(key.getShift()));
    }

    private String shiftBy(String text, int amount) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(text).toCharArray()) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount));
        }
        return sb.toString();
    }
}
