package cryptobench.ciphers.runningkey

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class RunningKeySuite : CipherSuite {
    override fun name(): String = "runningkey"

    override fun run(): SuiteResult {
        val cipher: Cipher = RunningKeyCipher(RunningKeyKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in RunningKeyVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
