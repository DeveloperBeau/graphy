package cryptobench.ciphers.tea

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class TeaSuite implements CipherSuite {
    String name() {
        return "tea"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new TeaCipher(TeaKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        TeaVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
