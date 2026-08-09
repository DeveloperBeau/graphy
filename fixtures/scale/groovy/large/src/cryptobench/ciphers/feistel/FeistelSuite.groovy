package cryptobench.ciphers.feistel

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class FeistelSuite implements CipherSuite {
    String name() {
        return "feistel"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new FeistelCipher(FeistelKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        FeistelVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
