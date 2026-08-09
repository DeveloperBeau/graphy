package calc.util

object NumberFormat {
  def trimTrailingZeros(formatted: String): String = {
    if (!formatted.contains('.')) formatted
    else formatted.reverse.dropWhile(_ == '0').dropWhile(_ == '.').reverse
  }

  /** Format an integer with thousands separators for the :vars listing. */
  def grouped(value: Long): String =
    String.format("%,d", Long.box(value))
}
