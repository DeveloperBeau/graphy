package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class PolybiusSuite extends CipherSuite {
  override def name: String = "polybius"

  override def run(): SuiteResult = {
    val cipher: Cipher = new PolybiusCipher(PolybiusKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- PolybiusVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
