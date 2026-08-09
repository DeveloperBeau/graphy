package cryptobench.ciphers.hill

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class HillSuite implements CipherSuite {
    String name() {
        return "hill"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new HillCipher(HillKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        HillVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
