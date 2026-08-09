package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairDigraphs
import cryptobench.core.Cipher
import cryptobench.util.Alphabet

/** Digraphs looked up across two keyword squares stacked vertically. */
class TwoSquareCipher implements Cipher {
    private final String top
    private final String bottom

    TwoSquareCipher(TwoSquareKey key) {
        this.top = key.topSquare()
        this.bottom = key.bottomSquare()
    }

    String name() {
        return "twosquare"
    }

    String encrypt(String plaintext) {
        return swap(PlayfairDigraphs.split(Alphabet.clean(plaintext)))
    }

    String decrypt(String ciphertext) {
        return swap(PlayfairDigraphs.split(Alphabet.clean(ciphertext)))
    }

    private String swap(String pairs) {
        StringBuilder sb = new StringBuilder()
        int i = 0
        while (i + 1 < pairs.length()) {
            int a = top.indexOf(pairs.charAt(i))
            int b = bottom.indexOf(pairs.charAt(i + 1))
            sb.append(top.charAt(a.intdiv(5) * 5 + b % 5)).append(bottom.charAt(b.intdiv(5) * 5 + a % 5))
            i += 2
        }
        return sb.toString()
    }
}
