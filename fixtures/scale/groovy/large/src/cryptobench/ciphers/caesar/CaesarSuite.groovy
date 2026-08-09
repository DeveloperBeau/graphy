package cryptobench.ciphers.caesar

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class CaesarSuite implements CipherSuite {
    String name() {
        return "caesar"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new CaesarCipher(CaesarKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        CaesarVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
