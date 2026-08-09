package cryptobench.ciphers.simon

final case class SimonKey(k0: Int, k1: Int, k2: Int, k3: Int) {

  def k(index: Int): Int = (index & 3) match {
    case 0 => k0
    case 1 => k1
    case 2 => k2
    case _ => k3
  }
}

object SimonKey {
  def default(): SimonKey = SimonKey(0x01234567, -0x76543211, -0x1234568, 0x76543210)
}
