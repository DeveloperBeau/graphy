package cryptobench.ciphers.hill

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class HillSuite : CipherSuite {
    override fun name(): String = "hill"

    override fun run(): SuiteResult {
        val cipher: Cipher = HillCipher(HillKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in HillVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
