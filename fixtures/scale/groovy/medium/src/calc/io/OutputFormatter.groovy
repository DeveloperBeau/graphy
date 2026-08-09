package calc.io

import calc.config.Settings
import calc.util.NumberFormat

class OutputFormatter {
    private final Settings settings

    OutputFormatter(Settings settings) {
        this.settings = settings
    }

    String format(double value) {
        if (Double.isNaN(value)) return "undefined"
        if (Double.isInfinite(value)) return value > 0 ? "infinity" : "-infinity"
        String text = String.format("%." + settings.precision + "f", value)
        return NumberFormat.trimTrailingZeros(text)
    }
}
