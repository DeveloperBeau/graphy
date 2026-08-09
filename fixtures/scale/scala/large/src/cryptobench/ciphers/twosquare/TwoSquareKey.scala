package cryptobench.ciphers.twosquare

import cryptobench.ciphers.playfair.PlayfairKey

final case class TwoSquareKey(topWord: String, bottomWord: String) {

  def topSquare: String = PlayfairKey(topWord).square

  def bottomSquare: String = PlayfairKey(bottomWord).square
}

object TwoSquareKey {
  def default(): TwoSquareKey = TwoSquareKey("EXAMPLE", "KEYWORD")
}
