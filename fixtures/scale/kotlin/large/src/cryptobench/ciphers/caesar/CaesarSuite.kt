package cryptobench.ciphers.caesar

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class CaesarSuite : CipherSuite {
    override fun name(): String = "caesar"

    override fun run(): SuiteResult {
        val cipher: Cipher = CaesarCipher(CaesarKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in CaesarVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
