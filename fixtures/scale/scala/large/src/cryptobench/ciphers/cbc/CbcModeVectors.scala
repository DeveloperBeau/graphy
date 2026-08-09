package cryptobench.ciphers.cbc

object CbcModeVectors {
  def samples(): List[String] = List(
      "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
      "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
      "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"
  )

  def count(): Int = samples().size
}
