package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class RouteSuite extends CipherSuite {
  override def name: String = "route"

  override def run(): SuiteResult = {
    val cipher: Cipher = new RouteCipher(RouteKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- RouteVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
