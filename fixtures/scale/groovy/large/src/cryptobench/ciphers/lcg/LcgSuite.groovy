package cryptobench.ciphers.lcg

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class LcgSuite implements CipherSuite {
    String name() {
        return "lcg"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new LcgCipher(LcgKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        LcgVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
