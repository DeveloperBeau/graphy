package cryptobench.ciphers.autokey

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class AutokeySuite implements CipherSuite {
    String name() {
        return "autokey"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new AutokeyCipher(AutokeyKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        AutokeyVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
