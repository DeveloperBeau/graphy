package calc.io

import calc.config.Settings
import calc.util.trimTrailingZeros

class OutputFormatter(private val settings: Settings) {

    fun format(value: Double): String {
        if (value.isNaN()) return "undefined"
        if (value.isInfinite()) return if (value > 0) "infinity" else "-infinity"
        val text = String.format("%." + settings.precision + "f", value)
        return trimTrailingZeros(text)
    }
}
