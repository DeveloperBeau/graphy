package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

final class Rot13Suite extends CipherSuite {
  override def name: String = "rot13"

  override def run(): SuiteResult = {
    val cipher: Cipher = new Rot13Cipher(Rot13Key.default())
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- Rot13Vectors.samples()) {
      if (RoundTrip.check(cipher, sample)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
