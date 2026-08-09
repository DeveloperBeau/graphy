package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Caesar with a fixed shift of 13, so encryption is its own inverse. */
class Rot13Cipher implements Cipher {
    private final Rot13Key key

    Rot13Cipher(Rot13Key key) {
        this.key = key
    }

    String name() {
        return "rot13"
    }

    String encrypt(String plaintext) {
        return shiftBy(plaintext, 13 * key.rounds)
    }

    String decrypt(String ciphertext) {
        return shiftBy(ciphertext, -(13 * key.rounds))
    }

    private String shiftBy(String text, int amount) {
        StringBuilder sb = new StringBuilder()
        Alphabet.clean(text).each { ch ->
            sb.append(Alphabet.charAt(Alphabet.indexOf(ch as char) + amount))
        }
        return sb.toString()
    }
}
