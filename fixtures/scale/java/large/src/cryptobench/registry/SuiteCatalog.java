package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;

public class SuiteCatalog {
    public static List<CipherSuite> allSuites(String filter) {
        List<CipherSuite> all = new ArrayList<>();
        all.addAll(ClassicalRegistry.suites());
        all.addAll(PolyalphabeticRegistry.suites());
        all.addAll(StreamRegistry.suites());
        all.addAll(TranspositionRegistry.suites());
        all.addAll(DigraphRegistry.suites());
        all.addAll(BlockRegistry.suites());
        all.addAll(HashRegistry.suites());
        if (filter == null || filter.isEmpty()) {
            return all;
        }
        return all.stream().filter(s -> s.name().contains(filter)).toList();
    }
}
