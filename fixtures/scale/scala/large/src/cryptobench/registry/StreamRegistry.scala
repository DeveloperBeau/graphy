package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.xorcipher.XorCipherSuite
import cryptobench.ciphers.rc4.Rc4Suite
import cryptobench.ciphers.xorshift.XorShiftSuite
import cryptobench.ciphers.lcg.LcgSuite

object StreamRegistry {
  def suites(): List[CipherSuite] = List(
    new XorCipherSuite,
    new Rc4Suite,
    new XorShiftSuite,
    new LcgSuite
  )
}
