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

class BlockRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new FeistelSuite()
        suites << new TeaSuite()
        suites << new XteaSuite()
        suites << new SpeckSuite()
        suites << new SimonSuite()
        suites << new EcbModeSuite()
        suites << new CbcModeSuite()
        suites << new CtrModeSuite()
        return suites
    }
}
