package cryptobench.ciphers.ctr

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class CtrModeSuite : CipherSuite {
    override fun name(): String = "ctr"

    override fun run(): SuiteResult {
        val cipher: Cipher = CtrModeCipher(CtrModeKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in CtrModeVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
