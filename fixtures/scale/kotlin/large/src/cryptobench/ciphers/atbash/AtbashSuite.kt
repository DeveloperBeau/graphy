package cryptobench.ciphers.atbash

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class AtbashSuite : CipherSuite {
    override fun name(): String = "atbash"

    override fun run(): SuiteResult {
        val cipher: Cipher = AtbashCipher(AtbashKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in AtbashVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
