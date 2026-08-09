package textprinter.style;

public class Theme {
    private final String name;
    private final int textColor;
    private final boolean emphasize;

    private Theme(String name, int textColor, boolean emphasize) {
        this.name = name;
        this.textColor = textColor;
        this.emphasize = emphasize;
    }

    public static Theme named(String name) {
        switch (name) {
            case "ocean":
                return new Theme(name, 36, false);
            case "alert":
                return new Theme(name, 31, true);
            case "forest":
                return new Theme(name, 32, false);
            default:
                return new Theme("plain", 0, false);
        }
    }

    public String apply(String text) {
        String styled = textColor == 0 ? text : Styles.colorize(text, textColor);
        return emphasize ? Styles.bold(styled) : styled;
    }

    public String getName() {
        return name;
    }
}
