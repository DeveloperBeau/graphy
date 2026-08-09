package cryptobench.ciphers.tea

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class TeaSuite : CipherSuite {
    override fun name(): String = "tea"

    override fun run(): SuiteResult {
        val cipher: Cipher = TeaCipher(TeaKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in TeaVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
