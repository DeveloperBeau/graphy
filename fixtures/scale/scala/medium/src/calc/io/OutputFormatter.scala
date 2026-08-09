package calc.io

import calc.config.Settings
import calc.util.NumberFormat

final class OutputFormatter(settings: Settings) {

  def format(value: Double): String = {
    if (value.isNaN) "undefined"
    else if (value.isInfinite) { if (value > 0) "infinity" else "-infinity" }
    else {
      val text = String.format("%." + settings.precision + "f", Double.box(value))
      NumberFormat.trimTrailingZeros(text)
    }
  }
}
