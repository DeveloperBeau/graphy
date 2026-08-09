package cryptobench.ciphers.feistel

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class FeistelSuite : CipherSuite {
    override fun name(): String = "feistel"

    override fun run(): SuiteResult {
        val cipher: Cipher = FeistelCipher(FeistelKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in FeistelVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
