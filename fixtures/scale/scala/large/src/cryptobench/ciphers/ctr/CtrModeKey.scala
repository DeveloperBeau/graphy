package cryptobench.ciphers.ctr

/** Parameters for the ctr cipher. */
final case class CtrModeKey(blockKey: Long) {
  def nonce: Long = blockKey ^ 0xC0DEC0DEL
}

object CtrModeKey {
  def default(): CtrModeKey = CtrModeKey(0x5115ABEDCAFED00DL)
}
