package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.playfair.PlayfairSuite
import cryptobench.ciphers.twosquare.TwoSquareSuite
import cryptobench.ciphers.foursquare.FourSquareSuite
import cryptobench.ciphers.hill.HillSuite
import cryptobench.ciphers.bifid.BifidSuite
import cryptobench.ciphers.adfgvx.AdfgvxSuite

class DigraphRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new PlayfairSuite()
        suites << new TwoSquareSuite()
        suites << new FourSquareSuite()
        suites << new HillSuite()
        suites << new BifidSuite()
        suites << new AdfgvxSuite()
        return suites
    }
}
