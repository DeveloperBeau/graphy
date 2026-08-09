package cryptobench.util

object Hex {
  private val Digits = "0123456789abcdef"

  def encode(data: Array[Byte]): String = {
    val sb = new StringBuilder(data.length * 2)
    for (b <- data) {
      sb.append(Digits((b >> 4) & 0xF)).append(Digits(b & 0xF))
    }
    sb.toString
  }

  def decode(hex: String): Array[Byte] =
    Array.tabulate(hex.length / 2)(i => Integer.parseInt(hex.substring(i * 2, i * 2 + 2), 16).toByte)
}
