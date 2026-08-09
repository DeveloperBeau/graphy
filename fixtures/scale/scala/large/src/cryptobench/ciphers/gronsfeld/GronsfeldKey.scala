package cryptobench.ciphers.gronsfeld

/** Parameters for the gronsfeld cipher. */
final case class GronsfeldKey(digits: String) {
  def digitAt(position: Int): Int = digits.charAt(position % digits.length) - '0'
}

object GronsfeldKey {
  def default(): GronsfeldKey = GronsfeldKey("31415")
}
