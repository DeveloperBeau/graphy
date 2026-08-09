package cryptobench.ciphers.sdbm

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

final class SdbmSuite extends CipherSuite {
  override def name: String = "sdbm"

  override def category: String = "hash"

  override def run(): SuiteResult = {
    val hash: HashFunction = new SdbmHash
    val samples = SdbmVectors.samples()
    var passed = 0
    var failed = 0
    val start = System.nanoTime()
    for (sample <- samples) {
      if (Determinism.stable(hash, sample)) passed += 1 else failed += 1
    }
    for (other <- samples) {
      if (Determinism.distinct(hash, samples.head, other)) passed += 1 else failed += 1
    }
    SuiteResult(name, passed, failed, System.nanoTime() - start)
  }
}
