package cryptobench.ciphers.runningkey

final case class RunningKeyKey(stream: String) {

  def keyCharAt(position: Int): Char = stream.charAt(position % stream.length)
}

object RunningKeyKey {
  private val Passage =
    "ITWASABRIGHTCOLDDAYINAPRILANDTHECLOCKSWERESTRIKINGTHIRTEEN"

  def default(): RunningKeyKey = RunningKeyKey(Passage)
}
