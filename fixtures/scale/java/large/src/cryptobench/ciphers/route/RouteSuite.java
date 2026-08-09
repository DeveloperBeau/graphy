package cryptobench.ciphers.route;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class RouteSuite implements CipherSuite {
    @Override
    public String name() {
        return "route";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new RouteCipher(RouteKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : RouteVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
