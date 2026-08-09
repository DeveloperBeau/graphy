package cryptobench.ciphers.djb2

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

final class Djb2Suite extends CipherSuite {
  override def name: String = "djb2"

  override def category: String = "hash"

  override def run(): SuiteResult = {
    val hash: HashFunction = new Djb2Hash
    val samples = Djb2Vectors.samples()
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
