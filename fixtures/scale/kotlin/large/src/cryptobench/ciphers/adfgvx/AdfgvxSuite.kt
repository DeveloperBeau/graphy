package cryptobench.ciphers.adfgvx

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class AdfgvxSuite : CipherSuite {
    override fun name(): String = "adfgvx"

    override fun run(): SuiteResult {
        val cipher: Cipher = AdfgvxCipher(AdfgvxKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in AdfgvxVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
