package cryptobench.ciphers.beaufort

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class BeaufortSuite : CipherSuite {
    override fun name(): String = "beaufort"

    override fun run(): SuiteResult {
        val cipher: Cipher = BeaufortCipher(BeaufortKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in BeaufortVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
