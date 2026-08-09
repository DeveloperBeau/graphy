package cryptobench.ciphers.foursquare;

import cryptobench.ciphers.playfair.PlayfairKey;

public class FourSquareKey {
    private final String upperWord;
    private final String lowerWord;

    public FourSquareKey(String upperWord, String lowerWord) {
        this.upperWord = upperWord;
        this.lowerWord = lowerWord;
    }

    public String upperSquare() {
        return new PlayfairKey(upperWord).square();
    }

    public String lowerSquare() {
        return new PlayfairKey(lowerWord).square();
    }

    public static FourSquareKey defaultKey() {
        return new FourSquareKey("WINTER", "SUMMER");
    }
}
