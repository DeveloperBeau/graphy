package cryptobench.ciphers.atbash

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class AtbashSuite implements CipherSuite {
    String name() {
        return "atbash"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new AtbashCipher(AtbashKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        AtbashVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
