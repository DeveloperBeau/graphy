package cryptobench.ciphers.myszkowski

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class MyszkowskiSuite implements CipherSuite {
    String name() {
        return "myszkowski"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new MyszkowskiCipher(MyszkowskiKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        MyszkowskiVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
