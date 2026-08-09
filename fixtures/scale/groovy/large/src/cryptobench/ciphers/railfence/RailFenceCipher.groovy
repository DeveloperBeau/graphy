package cryptobench.ciphers.railfence

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Writes the text in a zigzag across rails, then reads rail by rail. */
class RailFenceCipher implements Cipher {
    private final RailPattern pattern

    RailFenceCipher(RailFenceKey key) {
        this.pattern = new RailPattern(key.rails)
    }

    String name() {
        return "railfence"
    }

    String encrypt(String plaintext) {
        String text = Alphabet.clean(plaintext)
        StringBuilder[] rows = new StringBuilder[pattern.railCount()]
        for (int r = 0; r < rows.length; r++) rows[r] = new StringBuilder()
        for (int i = 0; i < text.length(); i++) rows[pattern.railFor(i)].append(text.charAt(i))
        StringBuilder sb = new StringBuilder()
        rows.each { row -> sb.append(row) }
        return sb.toString()
    }

    String decrypt(String ciphertext) {
        String text = Alphabet.clean(ciphertext)
        char[] out = new char[text.length()]
        int cursor = 0
        for (int r = 0; r < pattern.railCount(); r++) {
            for (int i = 0; i < text.length(); i++) {
                if (pattern.railFor(i) == r) out[i] = text.charAt(cursor++)
            }
        }
        return new String(out)
    }
}
