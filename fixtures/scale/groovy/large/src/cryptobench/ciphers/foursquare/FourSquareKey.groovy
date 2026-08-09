package cryptobench.ciphers.foursquare

import cryptobench.ciphers.playfair.PlayfairKey

class FourSquareKey {
    final String upperWord
    final String lowerWord

    FourSquareKey(String upperWord, String lowerWord) {
        this.upperWord = upperWord
        this.lowerWord = lowerWord
    }

    String upperSquare() {
        return new PlayfairKey(upperWord).square()
    }

    String lowerSquare() {
        return new PlayfairKey(lowerWord).square()
    }

    static FourSquareKey defaultKey() {
        return new FourSquareKey("WINTER", "SUMMER")
    }
}
