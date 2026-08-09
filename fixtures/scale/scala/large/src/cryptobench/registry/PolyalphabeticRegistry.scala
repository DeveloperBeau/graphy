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
  def suites(): List[CipherSuite] = List(
    new VigenereSuite,
    new BeaufortSuite,
    new VariantBeaufortSuite,
    new GronsfeldSuite,
    new AutokeySuite,
    new RunningKeySuite,
    new PortaSuite
  )
}
