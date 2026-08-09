package calc.io;

import java.io.PrintStream;

import calc.config.Settings;

public class ResultPrinter {
    private final OutputFormatter formatter;

    public ResultPrinter(Settings settings) {
        this.formatter = new OutputFormatter(settings);
    }

    public void print(PrintStream out, double value) {
        out.println("= " + formatter.format(value));
    }
}
