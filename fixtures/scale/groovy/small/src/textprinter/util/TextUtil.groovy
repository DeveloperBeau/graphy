package textprinter.util

class TextUtil {
    static String padTo(String line, int width) {
        return line.length() >= width ? line : line + (" " * (width - line.length()))
    }

    static String repeatChar(char c, int count) {
        return c.toString() * count
    }

    static int visibleLength(String line) {
        return line.replaceAll(/\u001b\[[0-9;]*m/, "").length()
    }
}
