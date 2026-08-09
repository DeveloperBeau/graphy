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
  def suites(): List[CipherSuite] = List(
    new Fnv1aSuite,
    new Djb2Suite,
    new SdbmSuite,
    new Adler32Suite,
    new Crc32Suite,
    new FletcherSuite,
    new PearsonSuite
  )
}
