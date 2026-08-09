package cryptobench.ciphers.xorcipher

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class XorCipherSuite implements CipherSuite {
    String name() {
        return "xorcipher"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new XorCipherCipher(XorCipherKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        XorCipherVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
