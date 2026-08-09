package cryptobench.ciphers.playfair;

import java.util.List;

public class PlayfairVectors {
    public static List<String> samples() {
        return List.of(
            "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
            "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
            "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG");
    }
}
