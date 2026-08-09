package cryptobench.ciphers.pearson

object PearsonVectors {
  def samples(): List[String] = List(
      "MEET ME AT THE HARBOUR AT MIDNIGHT",
      "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
      "COLD WINDS RISE OVER THE NORTHERN PASS"
  )

  def count(): Int = samples().size
}
