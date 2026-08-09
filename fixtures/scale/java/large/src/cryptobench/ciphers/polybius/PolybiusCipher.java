package cryptobench.ciphers.polybius;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Encodes each letter as its row/column pair in a 5x5 square (J folds into I). */
public class PolybiusCipher implements Cipher {
    private final String square;

    public PolybiusCipher(PolybiusKey key) {
        this.square = key.square();
    }

    @Override
    public String name() {
        return "polybius";
    }

    @Override
    public String encrypt(String plaintext) {
        StringBuilder sb = new StringBuilder();
        for (char c : Alphabet.clean(plaintext).replace('J', 'I').toCharArray()) {
            int at = square.indexOf(c);
            sb.append((char) ('1' + at / 5)).append((char) ('1' + at % 5));
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i + 1 < ciphertext.length(); i += 2) {
            int row = ciphertext.charAt(i) - '1';
            int col = ciphertext.charAt(i + 1) - '1';
            sb.append(square.charAt(row * 5 + col));
        }
        return sb.toString();
    }
}
