package cryptobench.ciphers.affine

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class AffineSuite : CipherSuite {
    override fun name(): String = "affine"

    override fun run(): SuiteResult {
        val cipher: Cipher = AffineCipher(AffineKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in AffineVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
