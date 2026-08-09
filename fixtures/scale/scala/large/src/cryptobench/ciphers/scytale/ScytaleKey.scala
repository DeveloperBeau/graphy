package cryptobench.ciphers.scytale

/** Parameters for the scytale cipher. */
final case class ScytaleKey(rows: Int) {
  def circumference: Int = rows
}

object ScytaleKey {
  def default(): ScytaleKey = ScytaleKey(4)
}
