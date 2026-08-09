package cryptobench.registry

import cryptobench.core.CipherSuite

class SuiteCatalog {
    static List<CipherSuite> allSuites(String filter) {
        List<CipherSuite> all = []
        all.addAll(ClassicalRegistry.suites())
        all.addAll(PolyalphabeticRegistry.suites())
        all.addAll(StreamRegistry.suites())
        all.addAll(TranspositionRegistry.suites())
        all.addAll(DigraphRegistry.suites())
        all.addAll(BlockRegistry.suites())
        all.addAll(HashRegistry.suites())
        if (filter == null || filter.isEmpty()) return all
        return all.findAll { it.name().contains(filter) }
    }
}
