package cryptobench.registry

import cryptobench.core.CipherSuite

object SuiteCatalog {
    fun allSuites(filter: String): List<CipherSuite> {
        val all = buildList {
            addAll(ClassicalRegistry.suites())
            addAll(PolyalphabeticRegistry.suites())
            addAll(StreamRegistry.suites())
            addAll(TranspositionRegistry.suites())
            addAll(DigraphRegistry.suites())
            addAll(BlockRegistry.suites())
            addAll(HashRegistry.suites())
        }
        if (filter.isEmpty()) return all
        return all.filter { it.name().contains(filter) }
    }
}
