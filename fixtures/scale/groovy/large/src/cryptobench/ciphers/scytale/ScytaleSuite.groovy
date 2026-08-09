package cryptobench.ciphers.scytale

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class ScytaleSuite implements CipherSuite {
    String name() {
        return "scytale"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new ScytaleCipher(ScytaleKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        ScytaleVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
