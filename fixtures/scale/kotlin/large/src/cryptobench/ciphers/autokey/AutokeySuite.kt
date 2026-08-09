package cryptobench.ciphers.autokey

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class AutokeySuite : CipherSuite {
    override fun name(): String = "autokey"

    override fun run(): SuiteResult {
        val cipher: Cipher = AutokeyCipher(AutokeyKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in AutokeyVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
