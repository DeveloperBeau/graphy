package cryptobench.ciphers.variantbeaufort

/** Parameters for the variantbeaufort cipher. */
final case class VariantBeaufortKey(keyword: String) {
  def keyCharAt(position: Int): Char = keyword.charAt(position % keyword.length)
}

object VariantBeaufortKey {
  def default(): VariantBeaufortKey = VariantBeaufortKey("COBALT")
}
