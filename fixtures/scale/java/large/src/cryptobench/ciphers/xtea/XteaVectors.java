package cryptobench.ciphers.xtea;

import java.util.List;

public class XteaVectors {
    public static List<String> samples() {
        return List.of(
            "MEET ME AT THE HARBOUR AT MIDNIGHT",
            "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
            "COLD WINDS RISE OVER THE NORTHERN PASS");
    }
}
