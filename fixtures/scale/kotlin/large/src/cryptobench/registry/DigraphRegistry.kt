package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.playfair.PlayfairSuite
import cryptobench.ciphers.twosquare.TwoSquareSuite
import cryptobench.ciphers.foursquare.FourSquareSuite
import cryptobench.ciphers.hill.HillSuite
import cryptobench.ciphers.bifid.BifidSuite
import cryptobench.ciphers.adfgvx.AdfgvxSuite

object DigraphRegistry {
    fun suites(): List<CipherSuite> = listOf(
        PlayfairSuite(),
        TwoSquareSuite(),
        FourSquareSuite(),
        HillSuite(),
        BifidSuite(),
        AdfgvxSuite(),
    )
}
