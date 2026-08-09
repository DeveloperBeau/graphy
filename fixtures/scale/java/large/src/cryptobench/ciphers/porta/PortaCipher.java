package cryptobench.ciphers.porta;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Reciprocal cipher over half-alphabets selected by the key letter. */
public class PortaCipher implements Cipher {
    private final PortaKey key;

    public PortaCipher(PortaKey key) {
        this.key = key;
    }

    @Override
    public String name() {
        return "porta";
    }

    @Override
    public String encrypt(String plaintext) {
        return swapHalves(Alphabet.clean(plaintext));
    }

    @Override
    public String decrypt(String ciphertext) {
        return swapHalves(Alphabet.clean(ciphertext));
    }

    private String swapHalves(String text) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < text.length(); i++) {
            int x = Alphabet.indexOf(text.charAt(i));
            int row = Alphabet.indexOf(key.keyCharAt(i)) / 2;
            int y = x < 13 ? 13 + Math.floorMod(x + row, 13) : Math.floorMod(x - 13 - row, 13);
            sb.append(Alphabet.charAt(y));
        }
        return sb.toString();
    }
}
