package cryptobench.ciphers.columnar

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

class ColumnarCipher implements Cipher {
    private final ColumnarKey key
    private final int[] order

    ColumnarCipher(ColumnarKey key) {
        this.key = key
        this.order = key.columnOrder()
    }

    String name() {
        return "columnar"
    }

    /** Write in rows, read the columns in keyword order. */
    String encrypt(String plaintext) {
        String text = key.padded(Alphabet.clean(plaintext))
        StringBuilder sb = new StringBuilder()
        order.each { col ->
            int row = 0
            while (row * order.length + col < text.length()) { sb.append(text.charAt(row * order.length + col)); row++ }
        }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        String text = Alphabet.clean(ciphertext)
        int rows = text.length().intdiv(order.length)
        char[] out = new char[text.length()]
        int cursor = 0
        order.each { col ->
            for (int row = 0; row < rows; row++) out[row * order.length + col] = text.charAt(cursor++)
        }
        return new String(out)
    }
}
