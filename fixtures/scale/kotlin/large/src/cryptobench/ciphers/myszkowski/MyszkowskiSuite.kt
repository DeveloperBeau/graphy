package cryptobench.ciphers.myszkowski

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class MyszkowskiSuite : CipherSuite {
    override fun name(): String = "myszkowski"

    override fun run(): SuiteResult {
        val cipher: Cipher = MyszkowskiCipher(MyszkowskiKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in MyszkowskiVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
