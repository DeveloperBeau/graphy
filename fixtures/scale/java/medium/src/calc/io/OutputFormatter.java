package calc.io;

import calc.config.Settings;

import static calc.util.NumberFormatUtil.trimTrailingZeros;

public class OutputFormatter {
    private final Settings settings;

    public OutputFormatter(Settings settings) {
        this.settings = settings;
    }

    public String format(double value) {
        if (Double.isNaN(value)) {
            return "undefined";
        }
        if (Double.isInfinite(value)) {
            return value > 0 ? "infinity" : "-infinity";
        }
        String text = String.format("%." + settings.getPrecision() + "f", value);
        return trimTrailingZeros(text);
    }
}
