package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class Rc4Suite extends CipherSuite {
  override def name: String = "rc4"

  override def run(): SuiteResult = {
    val cipher: Cipher = new Rc4Cipher(Rc4Key.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- Rc4Vectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
