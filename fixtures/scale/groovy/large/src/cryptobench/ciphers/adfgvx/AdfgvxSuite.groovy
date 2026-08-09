package cryptobench.ciphers.adfgvx

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class AdfgvxSuite implements CipherSuite {
    String name() {
        return "adfgvx"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new AdfgvxCipher(AdfgvxKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        AdfgvxVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
