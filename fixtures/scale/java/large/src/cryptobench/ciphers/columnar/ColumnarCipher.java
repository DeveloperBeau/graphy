package cryptobench.ciphers.columnar;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

public class ColumnarCipher implements Cipher {
    private final int[] order;

    public ColumnarCipher(ColumnarKey key) { this.order = key.columnOrder(); }

    @Override
    public String name() { return "columnar"; }

    /** Write in rows, read columns in keyword order. */
    @Override
    public String encrypt(String plaintext) {
        String text = padded(Alphabet.clean(plaintext));
        StringBuilder sb = new StringBuilder();
        for (int col : order) {
            for (int row = 0; row * order.length + col < text.length(); row++) {
                sb.append(text.charAt(row * order.length + col));
            }
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        String text = Alphabet.clean(ciphertext);
        int rows = text.length() / order.length, cursor = 0;
        char[] out = new char[text.length()];
        for (int col : order) {
            for (int row = 0; row < rows; row++) out[row * order.length + col] = text.charAt(cursor++);
        }
        return new String(out);
    }
}
