package textprinter.border;

public class Frames {
    public static Frame ascii() {
        return new Frame('+', '-', '|');
    }

    public static Frame rounded() {
        return new Frame('o', '─', '│');
    }

    public static Frame doubled() {
        return new Frame('╔', '═', '║');
    }

    public static Frame byName(String name) {
        switch (name) {
            case "rounded":
                return rounded();
            case "double":
                return doubled();
            default:
                return ascii();
        }
    }
}
