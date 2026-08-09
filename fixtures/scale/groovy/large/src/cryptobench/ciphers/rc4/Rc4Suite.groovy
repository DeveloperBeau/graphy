package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class Rc4Suite implements CipherSuite {
    String name() {
        return "rc4"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new Rc4Cipher(Rc4Key.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        Rc4Vectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
