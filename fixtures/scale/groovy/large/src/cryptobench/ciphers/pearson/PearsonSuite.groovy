package cryptobench.ciphers.pearson

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

class PearsonSuite implements CipherSuite {
    String name() {
        return "pearson"
    }

    String category() {
        return "hash"
    }

    SuiteResult run() {
        HashFunction hash = new PearsonHash()
        List<String> samples = PearsonVectors.samples()
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        samples.each { sample ->
            if (Determinism.stable(hash, sample)) passed++ else failed++
        }
        samples.each { other ->
            if (Determinism.distinct(hash, samples[0], other)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
