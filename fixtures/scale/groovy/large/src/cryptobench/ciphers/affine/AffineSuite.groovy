package cryptobench.ciphers.affine

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class AffineSuite implements CipherSuite {
    String name() {
        return "affine"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new AffineCipher(AffineKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        AffineVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
