package cryptobench.ciphers.speck

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class SpeckSuite implements CipherSuite {
    String name() {
        return "speck"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new SpeckCipher(SpeckKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        SpeckVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
