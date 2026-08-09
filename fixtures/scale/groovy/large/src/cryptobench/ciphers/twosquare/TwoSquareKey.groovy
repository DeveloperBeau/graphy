package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairKey

class TwoSquareKey {
    final String topWord
    final String bottomWord

    TwoSquareKey(String topWord, String bottomWord) {
        this.topWord = topWord
        this.bottomWord = bottomWord
    }

    String topSquare() {
        return new PlayfairKey(topWord).square()
    }

    String bottomSquare() {
        return new PlayfairKey(bottomWord).square()
    }

    static TwoSquareKey defaultKey() {
        return new TwoSquareKey("EXAMPLE", "KEYWORD")
    }
}
