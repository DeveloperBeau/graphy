package cryptobench.ciphers.adler32

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.distinctDigests
import cryptobench.verify.stableDigest

class Adler32Suite : CipherSuite {
    override fun name(): String = "adler32"

    override fun category(): String = "hash"

    override fun run(): SuiteResult {
        val hash: HashFunction = Adler32Hash()
        val samples = Adler32Vectors.samples()
        var passed = 0
        var failed = 0
        val start = System.nanoTime()
        for (sample in samples) {
            if (stableDigest(hash, sample)) passed++ else failed++
        }
        for (other in samples) {
            if (distinctDigests(hash, samples[0], other)) passed++ else failed++
        }
        return SuiteResult(name(), passed, failed, System.nanoTime() - start)
    }
}
