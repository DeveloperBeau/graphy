package cryptobench.ciphers.ctr;

import java.util.List;

public class CtrModeVectors {
    public static List<String> samples() {
        return List.of(
            "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
            "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
            "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS");
    }
}
