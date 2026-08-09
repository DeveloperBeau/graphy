package cryptobench.ciphers.lcg

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class LcgSuite : CipherSuite {
    override fun name(): String = "lcg"

    override fun run(): SuiteResult {
        val cipher: Cipher = LcgCipher(LcgKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in LcgVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
