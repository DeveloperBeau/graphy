package cryptobench.ciphers.playfair;

import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Digraph substitution over a 5x5 keyword square. */
public class PlayfairCipher implements Cipher {
    private final String square;

    public PlayfairCipher(PlayfairKey key) {
        this.square = key.square();
    }

    @Override
    public String name() {
        return "playfair";
    }

    @Override
    public String encrypt(String plaintext) {
        return PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(plaintext)), 1);
    }

    @Override
    public String decrypt(String ciphertext) {
        return PlayfairRules.transform(square, PlayfairDigraphs.split(Alphabet.clean(ciphertext)), 4);
    }
}
