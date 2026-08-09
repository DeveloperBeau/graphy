package cryptobench.ciphers.cbc

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class CbcModeSuite implements CipherSuite {
    String name() {
        return "cbc"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new CbcModeCipher(CbcModeKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        CbcModeVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
