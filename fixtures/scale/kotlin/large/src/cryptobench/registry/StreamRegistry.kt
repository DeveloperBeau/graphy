package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.xorcipher.XorCipherSuite
import cryptobench.ciphers.rc4.Rc4Suite
import cryptobench.ciphers.xorshift.XorShiftSuite
import cryptobench.ciphers.lcg.LcgSuite

object StreamRegistry {
    fun suites(): List<CipherSuite> = listOf(
        XorCipherSuite(),
        Rc4Suite(),
        XorShiftSuite(),
        LcgSuite(),
    )
}
