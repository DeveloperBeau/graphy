package cryptobench.ciphers.playfair

import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraph substitution over a 5x5 keyword square. */
class PlayfairCipher implements Cipher {
    private final String square

    PlayfairCipher(PlayfairKey key) {
        this.square = key.square()
    }

    String name() {
        return "playfair"
    }

    String encrypt(String plaintext) {
        return PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(plaintext)), 1)
    }

    String decrypt(String ciphertext) {
        return PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(ciphertext)), 4)
    }
}
