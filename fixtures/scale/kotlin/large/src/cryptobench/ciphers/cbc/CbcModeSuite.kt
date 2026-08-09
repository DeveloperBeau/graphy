package cryptobench.ciphers.cbc

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class CbcModeSuite : CipherSuite {
    override fun name(): String = "cbc"

    override fun run(): SuiteResult {
        val cipher: Cipher = CbcModeCipher(CbcModeKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in CbcModeVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
