package cryptobench.ciphers.ctr

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class CtrModeSuite implements CipherSuite {
    String name() {
        return "ctr"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new CtrModeCipher(CtrModeKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        CtrModeVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
