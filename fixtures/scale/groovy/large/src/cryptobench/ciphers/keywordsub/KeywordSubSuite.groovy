package cryptobench.ciphers.keywordsub

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class KeywordSubSuite implements CipherSuite {
    String name() {
        return "keywordsub"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new KeywordSubCipher(KeywordSubKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        KeywordSubVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
