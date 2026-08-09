package cryptobench.ciphers.gronsfeld

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class GronsfeldSuite implements CipherSuite {
    String name() {
        return "gronsfeld"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new GronsfeldCipher(GronsfeldKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        GronsfeldVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
