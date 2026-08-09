package cryptobench.ciphers.simon

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class SimonSuite : CipherSuite {
    override fun name(): String = "simon"

    override fun run(): SuiteResult {
        val cipher: Cipher = SimonCipher(SimonKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in SimonVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
