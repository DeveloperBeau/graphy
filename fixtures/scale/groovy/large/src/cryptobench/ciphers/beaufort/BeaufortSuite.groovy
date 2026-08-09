package cryptobench.ciphers.beaufort

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class BeaufortSuite implements CipherSuite {
    String name() {
        return "beaufort"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new BeaufortCipher(BeaufortKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        BeaufortVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
