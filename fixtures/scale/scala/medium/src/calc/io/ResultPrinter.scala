package calc.io

import calc.config.Settings

final class ResultPrinter(settings: Settings) {
  private val formatter = new OutputFormatter(settings)

  def print(value: Double): Unit =
    println("= " + formatter.format(value))
}
