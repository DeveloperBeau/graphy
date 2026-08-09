package cryptobench.ciphers.columnar

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class ColumnarSuite implements CipherSuite {
    String name() {
        return "columnar"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new ColumnarCipher(ColumnarKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        ColumnarVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
