package cryptobench.ciphers.rot13;

import java.util.List;

public class Rot13Vectors {
    public static List<String> samples() {
        return List.of(
            "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
            "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
            "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP");
    }
}
