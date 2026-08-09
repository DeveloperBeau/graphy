package textprinter.layout

import textprinter.util.TextUtil

class Aligner {
    static String alignLeft(String line, int width) {
        return TextUtil.padTo(line, width)
    }

    static String alignRight(String line, int width) {
        int gap = Math.max(0, width - line.length())
        return (" " * gap) + line
    }

    static String alignCenter(String line, int width) {
        int gap = Math.max(0, width - line.length())
        return TextUtil.padTo((" " * (gap.intdiv(2))) + line, width)
    }

    static String align(String line, int width, String mode) {
        switch (mode) {
            case "right": return alignRight(line, width)
            case "center": return alignCenter(line, width)
            default: return alignLeft(line, width)
        }
    }
}
