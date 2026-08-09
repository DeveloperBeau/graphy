package cryptobench.ciphers.vigenere

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class VigenereSuite implements CipherSuite {
    String name() {
        return "vigenere"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new VigenereCipher(VigenereKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        VigenereVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
