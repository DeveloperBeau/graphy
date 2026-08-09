package cryptobench.ciphers.djb2

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

class Djb2Suite implements CipherSuite {
    String name() {
        return "djb2"
    }

    String category() {
        return "hash"
    }

    SuiteResult run() {
        HashFunction hash = new Djb2Hash()
        List<String> samples = Djb2Vectors.samples()
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
