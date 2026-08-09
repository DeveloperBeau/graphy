package cryptobench.ciphers.porta

object PortaVectors {
  def samples(): List[String] = List(
      "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
      "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
      "SPHINX OF BLACK QUARTZ JUDGE MY VOW"
  )

  def count(): Int = samples().size
}
