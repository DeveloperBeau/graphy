package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes rows left to right, reads them back boustrophedon (snake order). */
class RouteCipher implements Cipher {
    private final int width

    RouteCipher(RouteKey key) {
        this.width = key.width
    }

    String name() {
        return "route"
    }

    String encrypt(String plaintext) {
        StringBuilder padded = new StringBuilder(Alphabet.clean(plaintext))
        while (padded.length() % width != 0) padded.append('X')
        return snake(padded.toString())
    }

    String decrypt(String ciphertext) {
        return snake(Alphabet.clean(ciphertext))
    }

    /** Reversing alternate rows is its own inverse, so both directions share it. */
    private String snake(String text) {
        StringBuilder sb = new StringBuilder()
        int row = 0
        while (row * width < text.length()) {
            String slice = text.substring(row * width, Math.min(row * width + width, text.length()))
            sb.append(row % 2 == 0 ? slice : slice.reverse())
            row++
        }
        return sb.toString()
    }
}
