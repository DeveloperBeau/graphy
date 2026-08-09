package cryptobench.ciphers.simon;

import java.util.List;

public class SimonVectors {
    public static List<String> samples() {
        return List.of(
            "COLD WINDS RISE OVER THE NORTHERN PASS",
            "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
            "THE ARCHIVE KEY IS UNDER THE FOURTH STONE");
    }
}
