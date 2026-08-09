package cryptobench.ciphers.beaufort

object BeaufortVectors {
  def samples(): List[String] = List(
      "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
      "COLD WINDS RISE OVER THE NORTHERN PASS",
      "SIGNAL FIRES BURN ALONG THE COAST TONIGHT"
  )

  def count(): Int = samples().size
}
