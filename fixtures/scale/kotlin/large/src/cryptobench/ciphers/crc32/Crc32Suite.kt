package cryptobench.ciphers.crc32

import cryptobench.core.CipherSuite
import cryptobench.core.HashFunction
import cryptobench.core.SuiteResult
import cryptobench.verify.distinctDigests
import cryptobench.verify.stableDigest

class Crc32Suite : CipherSuite {
    override fun name(): String = "crc32"

    override fun category(): String = "hash"

    override fun run(): SuiteResult {
        val hash: HashFunction = Crc32Hash()
        val samples = Crc32Vectors.samples()
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
