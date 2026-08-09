package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.RoundTrip

class RouteSuite implements CipherSuite {
    String name() {
        return "route"
    }

    String category() {
        return "cipher"
    }

    SuiteResult run() {
        Cipher cipher = new RouteCipher(RouteKey.defaultKey())
        int passed = 0
        int failed = 0
        long start = System.nanoTime()
        RouteVectors.samples().each { sample ->
            if (RoundTrip.check(cipher, sample)) passed++ else failed++
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
