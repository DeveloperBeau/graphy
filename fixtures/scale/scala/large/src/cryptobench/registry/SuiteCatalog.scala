package cryptobench.registry

import cryptobench.core.CipherSuite

object SuiteCatalog {
  def allSuites(filter: String): List[CipherSuite] = {
    val all = ClassicalRegistry.suites() ++
      PolyalphabeticRegistry.suites() ++
      StreamRegistry.suites() ++
      TranspositionRegistry.suites() ++
      DigraphRegistry.suites() ++
      BlockRegistry.suites() ++
      HashRegistry.suites()
    if (filter.isEmpty) all
    else all.filter(_.name.contains(filter))
  }
}
