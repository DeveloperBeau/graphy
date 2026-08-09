package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.fnv1a.Fnv1aSuite;
import cryptobench.ciphers.djb2.Djb2Suite;
import cryptobench.ciphers.sdbm.SdbmSuite;
import cryptobench.ciphers.adler32.Adler32Suite;
import cryptobench.ciphers.crc32.Crc32Suite;
import cryptobench.ciphers.fletcher.FletcherSuite;
import cryptobench.ciphers.pearson.PearsonSuite;

public class HashRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new Fnv1aSuite());
        suites.add(new Djb2Suite());
        suites.add(new SdbmSuite());
        suites.add(new Adler32Suite());
        suites.add(new Crc32Suite());
        suites.add(new FletcherSuite());
        suites.add(new PearsonSuite());
        return suites;
    }
}
