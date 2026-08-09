package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.railfence.RailFenceSuite;
import cryptobench.ciphers.columnar.ColumnarSuite;
import cryptobench.ciphers.scytale.ScytaleSuite;
import cryptobench.ciphers.route.RouteSuite;
import cryptobench.ciphers.myszkowski.MyszkowskiSuite;

public class TranspositionRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new RailFenceSuite());
        suites.add(new ColumnarSuite());
        suites.add(new ScytaleSuite());
        suites.add(new RouteSuite());
        suites.add(new MyszkowskiSuite());
        return suites;
    }
}
