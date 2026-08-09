package cryptobench.ciphers.porta;

import java.util.List;

public class PortaVectors {
    public static List<String> samples() {
        return List.of(
            "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
            "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
            "SPHINX OF BLACK QUARTZ JUDGE MY VOW");
    }
}
