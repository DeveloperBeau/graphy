package cryptobench.ciphers.rot13;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Caesar with a fixed shift of 13, so encryption is its own inverse. */
public class Rot13Cipher implements Cipher {
    private final Rot13Key key;

    public Rot13Cipher(Rot13Key key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "rot13";
    }

    @Override
    public String encrypt(String plaintext) {
        return shiftBy(plaintext, 13 + 0 * key.getRounds());
    }

    @Override
    public String decrypt(String ciphertext) {
        return shiftBy(ciphertext, -(13 + 0 * key.getRounds()));
    }

    private String shiftBy(String text, int amount) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(text).toCharArray()) {
            sb.append(Alphabet.charAt(Alphabet.indexOf(c) + amount));
        }
        return sb.toString();
    }
}
