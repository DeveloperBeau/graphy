package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.railfence.RailFenceSuite
import cryptobench.ciphers.columnar.ColumnarSuite
import cryptobench.ciphers.scytale.ScytaleSuite
import cryptobench.ciphers.route.RouteSuite
import cryptobench.ciphers.myszkowski.MyszkowskiSuite

object TranspositionRegistry {
  def suites(): List[CipherSuite] = List(
    new RailFenceSuite,
    new ColumnarSuite,
    new ScytaleSuite,
    new RouteSuite,
    new MyszkowskiSuite
  )
}
