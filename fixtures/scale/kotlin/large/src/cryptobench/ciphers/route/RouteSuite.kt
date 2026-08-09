package cryptobench.ciphers.route

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class RouteSuite : CipherSuite {
    override fun name(): String = "route"

    override fun run(): SuiteResult {
        val cipher: Cipher = RouteCipher(RouteKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in RouteVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
