package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.feistel.FeistelSuite
import cryptobench.ciphers.tea.TeaSuite
import cryptobench.ciphers.xtea.XteaSuite
import cryptobench.ciphers.speck.SpeckSuite
import cryptobench.ciphers.simon.SimonSuite
import cryptobench.ciphers.ecb.EcbModeSuite
import cryptobench.ciphers.cbc.CbcModeSuite
import cryptobench.ciphers.ctr.CtrModeSuite

object BlockRegistry {
  def suites(): List[CipherSuite] = List(
    new FeistelSuite,
    new TeaSuite,
    new XteaSuite,
    new SpeckSuite,
    new SimonSuite,
    new EcbModeSuite,
    new CbcModeSuite,
    new CtrModeSuite
  )
}
