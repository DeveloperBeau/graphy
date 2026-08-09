package cryptobench.ciphers.speck

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class SpeckSuite : CipherSuite {
    override fun name(): String = "speck"

    override fun run(): SuiteResult {
        val cipher: Cipher = SpeckCipher(SpeckKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in SpeckVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
