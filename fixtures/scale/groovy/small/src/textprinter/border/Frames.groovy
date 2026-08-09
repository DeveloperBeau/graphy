package textprinter.border

class Frames {
    static Frame ascii() {
        return new Frame('+' as char, '-' as char, '|' as char)
    }

    static Frame rounded() {
        return new Frame('o' as char, '-' as char, '|' as char)
    }

    static Frame byName(String name) {
        switch (name) {
            case "rounded": return rounded()
            default: return ascii()
        }
    }
}
