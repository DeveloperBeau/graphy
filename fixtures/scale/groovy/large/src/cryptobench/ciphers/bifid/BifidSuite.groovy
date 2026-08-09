package cryptobench.ciphers.bifid

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class BifidSuite implements CipherSuite {
    String name() {
        return "bifid"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new BifidCipher(BifidKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        BifidVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
