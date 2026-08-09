package cryptobench.ciphers.adler32;

import java.util.List;

public class Adler32Vectors {
    public static List<String> samples() {
        return List.of(
            "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP",
            "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
            "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ");
    }
}
