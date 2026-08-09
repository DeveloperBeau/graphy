package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.playfair.PlayfairSuite
import cryptobench.ciphers.twosquare.TwoSquareSuite
import cryptobench.ciphers.foursquare.FourSquareSuite
import cryptobench.ciphers.hill.HillSuite
import cryptobench.ciphers.bifid.BifidSuite
import cryptobench.ciphers.adfgvx.AdfgvxSuite

object DigraphRegistry {
  def suites(): List[CipherSuite] = List(
    new PlayfairSuite,
    new TwoSquareSuite,
    new FourSquareSuite,
    new HillSuite,
    new BifidSuite,
    new AdfgvxSuite
  )
}
