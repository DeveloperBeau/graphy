package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.vigenere.VigenereSuite
import cryptobench.ciphers.beaufort.BeaufortSuite
import cryptobench.ciphers.variantbeaufort.VariantBeaufortSuite
import cryptobench.ciphers.gronsfeld.GronsfeldSuite
import cryptobench.ciphers.autokey.AutokeySuite
import cryptobench.ciphers.runningkey.RunningKeySuite
import cryptobench.ciphers.porta.PortaSuite

object PolyalphabeticRegistry {
    fun suites(): List<CipherSuite> = listOf(
        VigenereSuite(),
        BeaufortSuite(),
        VariantBeaufortSuite(),
        GronsfeldSuite(),
        AutokeySuite(),
        RunningKeySuite(),
        PortaSuite(),
    )
}
