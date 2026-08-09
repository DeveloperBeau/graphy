package textprinter.border;

public class Frame {
    private final char corner;
    private final char horizontal;
    private final char vertical;

    public Frame(char corner, char horizontal, char vertical) {
        this.corner = corner;
        this.horizontal = horizontal;
        this.vertical = vertical;
    }

    public char getCorner() {
        return corner;
    }

    public char getHorizontal() {
        return horizontal;
    }

    public char getVertical() {
        return vertical;
    }
}
