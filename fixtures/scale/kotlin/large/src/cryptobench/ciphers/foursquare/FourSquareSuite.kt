package cryptobench.ciphers.foursquare

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class FourSquareSuite : CipherSuite {
    override fun name(): String = "foursquare"

    override fun run(): SuiteResult {
        val cipher: Cipher = FourSquareCipher(FourSquareKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in FourSquareVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
