package cryptobench.ciphers.crc32

object Crc32Vectors {
  def samples(): List[String] = List(
      "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
      "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
      "MEET ME AT THE HARBOUR AT MIDNIGHT"
  )

  def count(): Int = samples().size
}
