package cryptobench.ciphers.affine

final case class AffineKey(a: Int, b: Int) {

  def inverseOfA: Int = {
    (1 until 26).find(candidate => a * candidate % 26 == 1)
      .getOrElse(throw new IllegalStateException("a is not coprime with 26"))
  }
}

object AffineKey {
  def default(): AffineKey = AffineKey(5, 8)
}
