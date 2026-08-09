package cryptobench.ciphers.crc32

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.Determinism

class Crc32Suite implements CipherSuite {
    String name() {
        return "crc32"
    }

    String category() {
        return "hash"
    }

    SuiteResult run() {
        HashFunction hash = new Crc32Hash()
        List<String> samples = Crc32Vectors.samples()
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
