package cryptobench.ciphers.foursquare

import cryptobench.ciphers.playfair.PlayfairKey

final case class FourSquareKey(upperWord: String, lowerWord: String) {

  def upperSquare: String = PlayfairKey(upperWord).square

  def lowerSquare: String = PlayfairKey(lowerWord).square
}

object FourSquareKey {
  def default(): FourSquareKey = FourSquareKey("WINTER", "SUMMER")
}
