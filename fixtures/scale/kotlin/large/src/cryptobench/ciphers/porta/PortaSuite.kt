package cryptobench.ciphers.porta

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class PortaSuite : CipherSuite {
    override fun name(): String = "porta"

    override fun run(): SuiteResult {
        val cipher: Cipher = PortaCipher(PortaKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in PortaVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
