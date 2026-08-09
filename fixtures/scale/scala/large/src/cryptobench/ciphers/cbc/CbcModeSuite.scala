package cryptobench.ciphers.cbc

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class CbcModeSuite extends CipherSuite {
  override def name: String = "cbc"

  override def run(): SuiteResult = {
    val cipher: Cipher = new CbcModeCipher(CbcModeKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- CbcModeVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
