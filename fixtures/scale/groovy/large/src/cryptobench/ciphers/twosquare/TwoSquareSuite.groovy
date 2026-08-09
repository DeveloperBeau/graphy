package cryptobench.ciphers.twosquare

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class TwoSquareSuite implements CipherSuite {
    String name() {
        return "twosquare"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new TwoSquareCipher(TwoSquareKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        TwoSquareVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
