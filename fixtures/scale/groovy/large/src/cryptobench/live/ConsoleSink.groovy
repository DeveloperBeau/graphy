package cryptobench.live

class ConsoleSink {
    private final PrintStream out

    ConsoleSink(PrintStream out) {
        this.out = out
    }

    void line(String text) {
        out.println(text)
    }

    void transientLine(String text) {
        out.print("\r" + text)
        out.flush()
    }
}
