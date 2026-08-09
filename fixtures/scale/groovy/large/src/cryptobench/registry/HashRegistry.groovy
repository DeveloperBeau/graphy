package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.fnv1a.Fnv1aSuite
import cryptobench.ciphers.djb2.Djb2Suite
import cryptobench.ciphers.sdbm.SdbmSuite
import cryptobench.ciphers.adler32.Adler32Suite
import cryptobench.ciphers.crc32.Crc32Suite
import cryptobench.ciphers.fletcher.FletcherSuite
import cryptobench.ciphers.pearson.PearsonSuite

class HashRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new Fnv1aSuite()
        suites << new Djb2Suite()
        suites << new SdbmSuite()
        suites << new Adler32Suite()
        suites << new Crc32Suite()
        suites << new FletcherSuite()
        suites << new PearsonSuite()
        return suites
    }
}
