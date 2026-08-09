package cryptobench.ciphers.myszkowski

/** Parameters for the myszkowski cipher. */
final case class MyszkowskiKey(keyword: String) {
  def hasRepeats: Boolean = keyword.toSet.size < keyword.length
}

object MyszkowskiKey {
  def default(): MyszkowskiKey = MyszkowskiKey("TOMATO")
}
