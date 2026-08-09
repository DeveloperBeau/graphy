package cryptobench.ciphers.xorshift

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class XorShiftSuite : CipherSuite {
    override fun name(): String = "xorshift"

    override fun run(): SuiteResult {
        val cipher: Cipher = XorShiftCipher(XorShiftKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in XorShiftVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
