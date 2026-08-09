package cryptobench.ciphers.variantbeaufort

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class VariantBeaufortSuite implements CipherSuite {
    String name() {
        return "variantbeaufort"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new VariantBeaufortCipher(VariantBeaufortKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        VariantBeaufortVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
