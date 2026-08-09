package cryptobench.ciphers.feistel

object FeistelVectors {
  def samples(): List[String] = List(
      "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
      "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
      "MEET ME AT THE HARBOUR AT MIDNIGHT"
  )

  def count(): Int = samples().size
}
