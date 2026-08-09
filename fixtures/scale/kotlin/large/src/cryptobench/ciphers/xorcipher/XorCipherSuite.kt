package cryptobench.ciphers.xorcipher

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class XorCipherSuite : CipherSuite {
    override fun name(): String = "xorcipher"

    override fun run(): SuiteResult {
        val cipher: Cipher = XorCipherCipher(XorCipherKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in XorCipherVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
