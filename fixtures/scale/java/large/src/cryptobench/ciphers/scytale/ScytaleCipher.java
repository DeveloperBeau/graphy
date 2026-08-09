package cryptobench.ciphers.scytale;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Wraps text around a rod of fixed circumference and reads down the rod. */
public class ScytaleCipher implements Cipher {
    private final int rows;

    public ScytaleCipher(ScytaleKey key) { this.rows = key.getRows(); }

    @Override
    public String name() { return "scytale"; }

    @Override
    public String encrypt(String plaintext) {
        StringBuilder padded = new StringBuilder(Alphabet.clean(plaintext));
        while (padded.length() % rows != 0) padded.append('X');
        String text = padded.toString();
        int cols = text.length() / rows;
        StringBuilder sb = new StringBuilder();
        for (int c = 0; c < cols; c++) {
            for (int r = 0; r < rows; r++) sb.append(text.charAt(r * cols + c));
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        String text = Alphabet.clean(ciphertext);
        int cols = text.length() / rows;
        StringBuilder sb = new StringBuilder();
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) sb.append(text.charAt(c * rows + r));
        }
        return sb.toString();
    }
}
