package cryptobench.ciphers.playfair

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class PlayfairSuite implements CipherSuite {
    String name() {
        return "playfair"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new PlayfairCipher(PlayfairKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        PlayfairVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
