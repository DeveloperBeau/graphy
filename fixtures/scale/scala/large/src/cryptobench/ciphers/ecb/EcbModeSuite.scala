package cryptobench.ciphers.ecb

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class EcbModeSuite extends CipherSuite {
  override def name: String = "ecb"

  override def run(): SuiteResult = {
    val cipher: Cipher = new EcbModeCipher(EcbModeKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- EcbModeVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
