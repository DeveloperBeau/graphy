package textprinter.style

class Theme {
    String name
    int textColor
    boolean emphasize

    Theme(String name, int textColor, boolean emphasize) {
        this.name = name
        this.textColor = textColor
        this.emphasize = emphasize
    }

    String apply(String text) {
        String colored = textColor == 0 ? text : Styles.colorize(text, textColor)
        return emphasize ? Styles.bold(colored) : colored
    }

    static Theme named(String name) {
        switch (name) {
            case "ocean": return new Theme(name, 36, false)
            case "alert": return new Theme(name, 31, true)
            default: return new Theme("plain", 0, false)
        }
    }
}
