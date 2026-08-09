package cryptobench.ciphers.columnar

final case class ColumnarKey(keyword: String) {

  /** Column indexes sorted by their keyword letter, ties left to right. */
  def columnOrder: Array[Int] =
    keyword.toUpperCase.zipWithIndex.sortBy(p => (p._1, p._2)).map(_._2).toArray

  /** Pads with X until the text fills whole rows. */
  def padded(text: String): String = {
    val sb = new StringBuilder(text)
    while (sb.length % keyword.length != 0) sb.append('X')
    sb.toString
  }
}

object ColumnarKey {
  def default(): ColumnarKey = ColumnarKey("ZEBRAS")
}
