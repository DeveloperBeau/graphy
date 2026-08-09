package cryptobench.ciphers.gronsfeld

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class GronsfeldSuite : CipherSuite {
    override fun name(): String = "gronsfeld"

    override fun run(): SuiteResult {
        val cipher: Cipher = GronsfeldCipher(GronsfeldKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in GronsfeldVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
