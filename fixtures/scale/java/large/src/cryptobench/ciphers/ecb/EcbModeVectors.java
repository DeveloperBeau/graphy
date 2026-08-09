package cryptobench.ciphers.ecb;

import java.util.List;

public class EcbModeVectors {
    public static List<String> samples() {
        return List.of(
            "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
            "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
            "SILVER BIRDS CARRY WORDS ACROSS THE SEA");
    }
}
