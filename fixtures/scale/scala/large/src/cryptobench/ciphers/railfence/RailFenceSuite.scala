package cryptobench.ciphers.railfence

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class RailFenceSuite extends CipherSuite {
  override def name: String = "railfence"

  override def run(): SuiteResult = {
    val cipher: Cipher = new RailFenceCipher(RailFenceKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- RailFenceVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
