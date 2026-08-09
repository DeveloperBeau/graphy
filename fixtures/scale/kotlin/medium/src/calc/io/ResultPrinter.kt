package calc.io

import calc.config.Settings

class ResultPrinter(settings: Settings) {
    private val formatter = OutputFormatter(settings)

    fun print(value: Double) {
        println("= " + formatter.format(value))
    }
}
