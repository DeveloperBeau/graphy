package cryptobench.ciphers.polybius

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class PolybiusSuite : CipherSuite {
    override fun name(): String = "polybius"

    override fun run(): SuiteResult {
        val cipher: Cipher = PolybiusCipher(PolybiusKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in PolybiusVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
