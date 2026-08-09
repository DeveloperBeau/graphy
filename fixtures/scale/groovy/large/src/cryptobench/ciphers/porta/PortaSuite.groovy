package cryptobench.ciphers.porta

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class PortaSuite implements CipherSuite {
    String name() {
        return "porta"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new PortaCipher(PortaKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        PortaVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
