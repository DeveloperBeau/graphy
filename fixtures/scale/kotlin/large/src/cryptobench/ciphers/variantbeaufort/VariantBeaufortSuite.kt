package cryptobench.ciphers.variantbeaufort

import cryptobench.core.Cipher
import cryptobench.core.CipherSuite
import cryptobench.core.SuiteResult
import cryptobench.verify.roundTrip

class VariantBeaufortSuite : CipherSuite {
    override fun name(): String = "variantbeaufort"

    override fun run(): SuiteResult {
        val cipher: Cipher = VariantBeaufortCipher(VariantBeaufortKey.default())
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in VariantBeaufortVectors.samples()) {
            if (roundTrip(cipher, sample)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
