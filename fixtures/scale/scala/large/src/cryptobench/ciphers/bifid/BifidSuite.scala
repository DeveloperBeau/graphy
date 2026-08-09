package cryptobench.ciphers.bifid

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class BifidSuite extends CipherSuite {
  override def name: String = "bifid"

  override def run(): SuiteResult = {
    val cipher: Cipher = new BifidCipher(BifidKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- BifidVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
