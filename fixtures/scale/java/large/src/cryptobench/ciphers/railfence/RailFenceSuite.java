package cryptobench.ciphers.railfence;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class RailFenceSuite implements CipherSuite {
    @Override
    public String name() {
        return "railfence";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new RailFenceCipher(RailFenceKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : RailFenceVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
