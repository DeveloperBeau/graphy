package calc.io

import calc.config.Settings

class ResultPrinter {
    private final OutputFormatter formatter

    ResultPrinter(Settings settings) {
        this.formatter = new OutputFormatter(settings)
    }

    void print(double value) {
        println "= " + formatter.format(value)
    }
}
