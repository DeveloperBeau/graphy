package cryptobench.ciphers.xtea

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class XteaSuite extends CipherSuite {
  override def name: String = "xtea"

  override def run(): SuiteResult = {
    val cipher: Cipher = new XteaCipher(XteaKey.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- XteaVectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
