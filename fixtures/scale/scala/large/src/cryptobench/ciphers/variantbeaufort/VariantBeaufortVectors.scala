package cryptobench.ciphers.variantbeaufort

object VariantBeaufortVectors {
  def samples(): List[String] = List(
      "COLD WINDS RISE OVER THE NORTHERN PASS",
      "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
      "THE ARCHIVE KEY IS UNDER THE FOURTH STONE"
  )

  def count(): Int = samples().size
}
