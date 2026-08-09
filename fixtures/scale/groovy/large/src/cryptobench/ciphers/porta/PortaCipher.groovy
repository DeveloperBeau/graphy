package cryptobench.ciphers.porta

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Reciprocal cipher over half-alphabets selected by the key letter. */
class PortaCipher implements Cipher {
    private final PortaKey key

    PortaCipher(PortaKey key) {
        this.key = key
    }

    String name() {
        return "porta"
    }

    String encrypt(String plaintext) {
        return swapHalves(Alphabet.clean(plaintext))
    }

    String decrypt(String ciphertext) {
        return swapHalves(Alphabet.clean(ciphertext))
    }

    private String swapHalves(String text) {
        StringBuilder sb = new StringBuilder()
        for (int i = 0; i < text.length(); i++) {
            int x = Alphabet.indexOf(text.charAt(i))
            int row = Alphabet.indexOf(key.keyCharAt(i)).intdiv(2)
            int y = x < 13 ? 13 + Math.floorMod(x + row, 13) : Math.floorMod(x - 13 - row, 13)
            sb.append(Alphabet.charAt(y))
        }
        return sb.toString()
    }
}
