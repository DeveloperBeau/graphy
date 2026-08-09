package cryptobench.ciphers.sdbm

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

class SdbmSuite implements CipherSuite {
    String name() {
        return "sdbm"
    }

    String category() {
        return "hash"
    }

    SuiteResult run() {
        HashFunction hash = new SdbmHash()
        List<String> samples = SdbmVectors.samples()
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
