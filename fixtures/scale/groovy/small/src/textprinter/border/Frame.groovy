package textprinter.border

class Frame {
    char corner
    char horizontal
    char vertical

    Frame(char corner, char horizontal, char vertical) {
        this.corner = corner
        this.horizontal = horizontal
        this.vertical = vertical
    }

    String rule(int innerWidth) {
        return corner.toString() + (horizontal.toString() * (innerWidth + 2)) + corner.toString()
    }
}
