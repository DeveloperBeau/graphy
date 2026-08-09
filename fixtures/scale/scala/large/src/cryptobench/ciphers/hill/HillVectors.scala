package cryptobench.ciphers.hill

object HillVectors {
  def samples(): List[String] = List(
      "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
      "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
      "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP"
  )

  def count(): Int = samples().size
}
