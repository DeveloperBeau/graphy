package cryptobench.live;

import java.io.PrintStream;

public class ConsoleSink {
    private final PrintStream out;

    public ConsoleSink(PrintStream out) {
        this.out = out;
    }

    public void line(String text) {
        out.println(text);
    }

    public void transient_(String text) {
        out.print("\r" + text);
        out.flush();
    }
}
