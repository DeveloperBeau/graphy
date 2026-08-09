package textprinter.util;

public class TextUtil {
    public static String padTo(String line, int width) {
        if (line.length() >= width) {
            return line;
        }
        return line + " ".repeat(width - line.length());
    }

    public static String repeatChar(char c, int count) {
        StringBuilder sb = new StringBuilder(count);
        for (int i = 0; i < count; i++) {
            sb.append(c);
        }
        return sb.toString();
    }

    public static int visibleLength(String line) {
        return line.replaceAll("\\[[0-9;]*m", "").length();
    }
}
