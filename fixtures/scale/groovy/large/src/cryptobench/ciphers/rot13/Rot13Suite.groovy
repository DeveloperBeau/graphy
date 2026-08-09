package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class Rot13Suite implements CipherSuite {
    String name() {
        return "rot13"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new Rot13Cipher(Rot13Key.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        Rot13Vectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
