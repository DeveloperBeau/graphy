package cryptobench.ciphers.caesar;

import java.util.List;

public class CaesarVectors {
    public static List<String> samples() {
        return List.of(
            "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
            "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
            "SPHINX OF BLACK QUARTZ JUDGE MY VOW");
    }
}
