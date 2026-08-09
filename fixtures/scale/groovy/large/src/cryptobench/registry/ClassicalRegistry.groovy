package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.caesar.CaesarSuite
import cryptobench.ciphers.rot13.Rot13Suite
import cryptobench.ciphers.atbash.AtbashSuite
import cryptobench.ciphers.affine.AffineSuite
import cryptobench.ciphers.keywordsub.KeywordSubSuite
import cryptobench.ciphers.polybius.PolybiusSuite

class ClassicalRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new CaesarSuite()
        suites << new Rot13Suite()
        suites << new AtbashSuite()
        suites << new AffineSuite()
        suites << new KeywordSubSuite()
        suites << new PolybiusSuite()
        return suites
    }
}
