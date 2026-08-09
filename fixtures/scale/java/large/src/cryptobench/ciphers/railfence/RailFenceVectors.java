package cryptobench.ciphers.railfence;

import java.util.List;

public class RailFenceVectors {
    public static List<String> samples() {
        return List.of(
            "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
            "MEET ME AT THE HARBOUR AT MIDNIGHT",
            "THE PACKAGE ARRIVES ON THE THIRD TRAIN");
    }
}
