package cryptobench.registry;

import java.util.ArrayList;
import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.ciphers.xorcipher.XorCipherSuite;
import cryptobench.ciphers.rc4.Rc4Suite;
import cryptobench.ciphers.xorshift.XorShiftSuite;
import cryptobench.ciphers.lcg.LcgSuite;

public class StreamRegistry {
    public static List<CipherSuite> suites() {
        List<CipherSuite> suites = new ArrayList<>();
        suites.add(new XorCipherSuite());
        suites.add(new Rc4Suite());
        suites.add(new XorShiftSuite());
        suites.add(new LcgSuite());
        return suites;
    }
}
