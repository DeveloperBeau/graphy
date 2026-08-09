package cryptobench.ciphers.runningkey

object RunningKeyVectors {
  def samples(): List[String] = List(
      "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
      "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
      "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS"
  )

  def count(): Int = samples().size
}
