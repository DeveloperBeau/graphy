package cryptobench.ciphers.twosquare

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class TwoSquareSuite : CipherSuite {
    override fun name(): String = "twosquare"

    override fun run(): SuiteResult {
        val cipher: Cipher = TwoSquareCipher(TwoSquareKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in TwoSquareVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
