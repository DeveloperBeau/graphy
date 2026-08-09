package textprinter.style;

public class Styles {
    public static final String ESC = "\u001b[";
    public static final String RESET = ESC + "0m";

    public static String bold(String text) {
        return ESC + "1m" + text + RESET;
    }

    public static String dim(String text) {
        return ESC + "2m" + text + RESET;
    }

    public static String underline(String text) {
        return ESC + "4m" + text + RESET;
    }

    public static String colorize(String text, int ansiCode) {
        return ESC + ansiCode + "m" + text + RESET;
    }
}
