package cryptobench.ciphers.foursquare;

import cryptobench.ciphers.playfair.PlayfairDigraphs;
import cryptobench.ciphers.playfair.PlayfairKey;
import cryptobench.core.Cipher;
import cryptobench.util.Alphabet;

/** Plain squares on one diagonal, keyword squares on the other. */
public class FourSquareCipher implements Cipher {
    private static final String PLAIN = new PlayfairKey("").square();
    private final FourSquareKey key;

    public FourSquareCipher(FourSquareKey key) { this.key = key; }

    @Override
    public String name() { return "foursquare"; }

    @Override
    public String encrypt(String plaintext) {
        String pairs = PlayfairDigraphs.split(Alphabet.clean(plaintext));
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i + 1 < pairs.length(); i += 2) {
            int a = PLAIN.indexOf(pairs.charAt(i)), b = PLAIN.indexOf(pairs.charAt(i + 1));
            sb.append(key.upperSquare().charAt(a / 5 * 5 + b % 5)).append(key.lowerSquare().charAt(b / 5 * 5 + a % 5));
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String ciphertext) {
        String pairs = Alphabet.clean(ciphertext);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i + 1 < pairs.length(); i += 2) {
            int a = key.upperSquare().indexOf(pairs.charAt(i)), b = key.lowerSquare().indexOf(pairs.charAt(i + 1));
            sb.append(PLAIN.charAt(a / 5 * 5 + b % 5)).append(PLAIN.charAt(b / 5 * 5 + a % 5));
        }
        return sb.toString();
    }
}
