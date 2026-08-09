package cryptobench.ciphers.route;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Writes rows left to right, reads them back boustrophedon (snake order). */
public class RouteCipher implements Cipher {
    private final int width;

    public RouteCipher(RouteKey key) { this.width = key.getWidth(); }

    @Override
    public String name() { return "route"; }

    @Override
    public String encrypt(String plaintext) {
        StringBuilder padded = new StringBuilder(Alphabet.clean(plaintext));
        while (padded.length() % width != 0) padded.append('X');
        return snake(padded.toString());
    }

    @Override
    public String decrypt(String ciphertext) {
        return snake(Alphabet.clean(ciphertext));
    }

    /** Reversing alternate rows is its own inverse, so both directions share it. */
    private String snake(String text) {
        StringBuilder sb = new StringBuilder();
        for (int row = 0; row * width < text.length(); row++) {
            String slice = text.substring(row * width, Math.min(row * width + width, text.length()));
            sb.append(row % 2 == 0 ? slice : new StringBuilder(slice).reverse());
        }
        return sb.toString();
    }
}
