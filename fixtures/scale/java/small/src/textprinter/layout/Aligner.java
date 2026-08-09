package textprinter.layout;

import static textprinter.util.TextUtil.padTo;

public class Aligner {
    public static String alignLeft(String line, int width) {
        return padTo(line, width);
    }

    public static String alignRight(String line, int width) {
        int gap = Math.max(0, width - line.length());
        return " ".repeat(gap) + line;
    }

    public static String alignCenter(String line, int width) {
        int gap = Math.max(0, width - line.length());
        int left = gap / 2;
        return padTo(" ".repeat(left) + line, width);
    }

    public static String align(String line, int width, String mode) {
        switch (mode) {
            case "right":
                return alignRight(line, width);
            case "center":
                return alignCenter(line, width);
            default:
                return alignLeft(line, width);
        }
    }
}
