package cryptobench.ciphers.scytale

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class ScytaleSuite : CipherSuite {
    override fun name(): String = "scytale"

    override fun run(): SuiteResult {
        val cipher: Cipher = ScytaleCipher(ScytaleKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in ScytaleVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
