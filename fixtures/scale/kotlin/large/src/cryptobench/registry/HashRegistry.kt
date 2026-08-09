package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.fnv1a.Fnv1aSuite
import cryptobench.ciphers.djb2.Djb2Suite
import cryptobench.ciphers.sdbm.SdbmSuite
import cryptobench.ciphers.adler32.Adler32Suite
import cryptobench.ciphers.crc32.Crc32Suite
import cryptobench.ciphers.fletcher.FletcherSuite
import cryptobench.ciphers.pearson.PearsonSuite

object HashRegistry {
    fun suites(): List<CipherSuite> = listOf(
        Fnv1aSuite(),
        Djb2Suite(),
        SdbmSuite(),
        Adler32Suite(),
        Crc32Suite(),
        FletcherSuite(),
        PearsonSuite(),
    )
}
