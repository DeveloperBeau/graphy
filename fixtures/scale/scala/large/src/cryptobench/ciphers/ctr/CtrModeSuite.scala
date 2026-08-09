package cryptobench.ciphers.ctr

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class CtrModeSuite extends CipherSuite {
  override def name: String = "ctr"

  override def run(): SuiteResult = {
    val cipher: Cipher = new CtrModeCipher(CtrModeKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- CtrModeVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
