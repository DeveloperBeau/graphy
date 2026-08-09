package cryptobench.ciphers.ecb

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class EcbModeSuite implements CipherSuite {
    String name() {
        return "ecb"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new EcbModeCipher(EcbModeKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        EcbModeVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
