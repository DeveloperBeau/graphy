package cryptobench.ciphers.rot13

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class Rot13Suite : CipherSuite {
    override fun name(): String = "rot13"

    override fun run(): SuiteResult {
        val cipher: Cipher = Rot13Cipher(Rot13Key.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in Rot13Vectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
