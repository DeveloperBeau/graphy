package cryptobench.ciphers.vigenere

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class VigenereSuite : CipherSuite {
    override fun name(): String = "vigenere"

    override fun run(): SuiteResult {
        val cipher: Cipher = VigenereCipher(VigenereKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in VigenereVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
