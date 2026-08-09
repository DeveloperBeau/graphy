package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.railfence.RailFenceSuite
import cryptobench.ciphers.columnar.ColumnarSuite
import cryptobench.ciphers.scytale.ScytaleSuite
import cryptobench.ciphers.route.RouteSuite
import cryptobench.ciphers.myszkowski.MyszkowskiSuite

class TranspositionRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new RailFenceSuite()
        suites << new ColumnarSuite()
        suites << new ScytaleSuite()
        suites << new RouteSuite()
        suites << new MyszkowskiSuite()
        return suites
    }
}
