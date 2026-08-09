package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class PolybiusSuite implements CipherSuite {
    String name() {
        return "polybius"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new PolybiusCipher(PolybiusKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        PolybiusVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
