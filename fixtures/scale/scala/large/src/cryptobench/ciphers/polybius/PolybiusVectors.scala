package cryptobench.ciphers.polybius

object PolybiusVectors {
  def samples(): List[String] = List(
      "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
      "MEET ME AT THE HARBOUR AT MIDNIGHT",
      "THE PACKAGE ARRIVES ON THE THIRD TRAIN"
  )

  def count(): Int = samples().size
}
