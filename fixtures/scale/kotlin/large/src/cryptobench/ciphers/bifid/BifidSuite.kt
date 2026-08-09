package cryptobench.ciphers.bifid

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class BifidSuite : CipherSuite {
    override fun name(): String = "bifid"

    override fun run(): SuiteResult {
        val cipher: Cipher = BifidCipher(BifidKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in BifidVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
