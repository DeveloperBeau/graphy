package cryptobench.ciphers.twosquare;

import cryptobench.ciphers.playfair.PlayfairDigraphs;
import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Digraphs looked up across two keyword squares stacked vertically. */
public class TwoSquareCipher implements Cipher {
    private final String top;
    private final String bottom;

    public TwoSquareCipher(TwoSquareKey key) {
        this.top = key.topSquare();
        this.bottom = key.bottomSquare();
    }

    @Override
    public String name() { return "twosquare"; }

    @Override
    public String encrypt(String plaintext) { return swap(PlayfairDigraphs.split(Alphabet.clean(plaintext))); }

    @Override
    public String decrypt(String ciphertext) { return swap(PlayfairDigraphs.split(Alphabet.clean(ciphertext))); }

    private String swap(String pairs) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i + 1 < pairs.length(); i += 2) {
            int a = top.indexOf(pairs.charAt(i));
            int b = bottom.indexOf(pairs.charAt(i + 1));
            sb.append(top.charAt(a / 5 * 5 + b % 5)).append(bottom.charAt(b / 5 * 5 + a % 5));
        }
        return sb.toString();
    }
}
