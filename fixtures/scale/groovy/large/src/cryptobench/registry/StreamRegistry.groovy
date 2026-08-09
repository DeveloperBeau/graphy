package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.xorcipher.XorCipherSuite
import cryptobench.ciphers.rc4.Rc4Suite
import cryptobench.ciphers.xorshift.XorShiftSuite
import cryptobench.ciphers.lcg.LcgSuite

class StreamRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new XorCipherSuite()
        suites << new Rc4Suite()
        suites << new XorShiftSuite()
        suites << new LcgSuite()
        return suites
    }
}
