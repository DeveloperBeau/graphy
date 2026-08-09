package cryptobench.ciphers.columnar

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class ColumnarSuite : CipherSuite {
    override fun name(): String = "columnar"

    override fun run(): SuiteResult {
        val cipher: Cipher = ColumnarCipher(ColumnarKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in ColumnarVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
