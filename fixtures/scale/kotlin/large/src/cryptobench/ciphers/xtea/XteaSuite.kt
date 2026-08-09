package cryptobench.ciphers.xtea

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class XteaSuite : CipherSuite {
    override fun name(): String = "xtea"

    override fun run(): SuiteResult {
        val cipher: Cipher = XteaCipher(XteaKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in XteaVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
