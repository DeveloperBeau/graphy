package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.caesar.CaesarSuite
import cryptobench.ciphers.rot13.Rot13Suite
import cryptobench.ciphers.atbash.AtbashSuite
import cryptobench.ciphers.affine.AffineSuite
import cryptobench.ciphers.keywordsub.KeywordSubSuite
import cryptobench.ciphers.polybius.PolybiusSuite

object ClassicalRegistry {
    fun suites(): List<CipherSuite> = listOf(
        CaesarSuite(),
        Rot13Suite(),
        AtbashSuite(),
        AffineSuite(),
        KeywordSubSuite(),
        PolybiusSuite(),
    )
}
