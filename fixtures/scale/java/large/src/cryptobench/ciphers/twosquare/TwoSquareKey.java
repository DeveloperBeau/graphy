package cryptobench.ciphers.twosquare;

import cryptobench.ciphers.playfair.PlayfairKey;

public class TwoSquareKey {
    private final String topWord;
    private final String bottomWord;

    public TwoSquareKey(String topWord, String bottomWord) {
        this.topWord = topWord;
        this.bottomWord = bottomWord;
    }

    public String topSquare() {
        return new PlayfairKey(topWord).square();
    }

    public String bottomSquare() {
        return new PlayfairKey(bottomWord).square();
    }

    public static TwoSquareKey defaultKey() {
        return new TwoSquareKey("EXAMPLE", "KEYWORD");
    }
}
