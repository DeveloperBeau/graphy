package textprinter.style

class Styles {
    static final String ESC = "\u001b["
    static final String RESET = ESC + "0m"

    static String bold(String text) {
        return ESC + "1m" + text + RESET
    }

    static String dim(String text) {
        return ESC + "2m" + text + RESET
    }

    static String colorize(String text, int ansiCode) {
        return ESC + ansiCode + "m" + text + RESET
    }
}
