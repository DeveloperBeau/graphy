package cryptobench.ciphers.ecb

/** Parameters for the ecb cipher. */
final case class EcbModeKey(blockKey: Long) {
  def rotated: EcbModeKey = EcbModeKey(java.lang.Long.rotateLeft(blockKey, 8))
}

object EcbModeKey {
  def default(): EcbModeKey = EcbModeKey(0x5115ABEDCAFED00DL)
}
