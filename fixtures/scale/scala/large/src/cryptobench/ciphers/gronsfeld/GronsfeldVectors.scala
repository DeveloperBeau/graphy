package cryptobench.ciphers.gronsfeld

object GronsfeldVectors {
  def samples(): List[String] = List(
      "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
      "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
      "SILVER BIRDS CARRY WORDS ACROSS THE SEA"
  )

  def count(): Int = samples().size
}
