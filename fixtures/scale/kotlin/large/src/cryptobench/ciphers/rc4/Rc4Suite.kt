package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class Rc4Suite : CipherSuite {
    override fun name(): String = "rc4"

    override fun run(): SuiteResult {
        val cipher: Cipher = Rc4Cipher(Rc4Key.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in Rc4Vectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
