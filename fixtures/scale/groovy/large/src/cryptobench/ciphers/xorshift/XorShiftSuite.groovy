package cryptobench.ciphers.xorshift

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class XorShiftSuite implements CipherSuite {
    String name() {
        return "xorshift"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new XorShiftCipher(XorShiftKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        XorShiftVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
