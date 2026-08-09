package cryptobench.ciphers.railfence

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class RailFenceSuite implements CipherSuite {
    String name() {
        return "railfence"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new RailFenceCipher(RailFenceKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        RailFenceVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
