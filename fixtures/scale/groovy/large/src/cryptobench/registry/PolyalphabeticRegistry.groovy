package cryptobench.registry

import cryptobench.core.CipherSuite
import cryptobench.ciphers.vigenere.VigenereSuite
import cryptobench.ciphers.beaufort.BeaufortSuite
import cryptobench.ciphers.variantbeaufort.VariantBeaufortSuite
import cryptobench.ciphers.gronsfeld.GronsfeldSuite
import cryptobench.ciphers.autokey.AutokeySuite
import cryptobench.ciphers.runningkey.RunningKeySuite
import cryptobench.ciphers.porta.PortaSuite

class PolyalphabeticRegistry {
    static List<CipherSuite> suites() {
        List<CipherSuite> suites = []
        suites << new VigenereSuite()
        suites << new BeaufortSuite()
        suites << new VariantBeaufortSuite()
        suites << new GronsfeldSuite()
        suites << new AutokeySuite()
        suites << new RunningKeySuite()
        suites << new PortaSuite()
        return suites
    }
}
