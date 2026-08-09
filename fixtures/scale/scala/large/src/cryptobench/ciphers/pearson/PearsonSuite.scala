package cryptobench.ciphers.pearson

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

final class PearsonSuite extends CipherSuite {
  override def name: String = "pearson"

  override def category: String = "hash"

  override def run(): SuiteResult = {
    val hash: HashFunction = new PearsonHash
    val samples = PearsonVectors.samples()
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
