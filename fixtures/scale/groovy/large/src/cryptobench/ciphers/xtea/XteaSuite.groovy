package cryptobench.ciphers.xtea

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class XteaSuite implements CipherSuite {
    String name() {
        return "xtea"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new XteaCipher(XteaKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        XteaVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
