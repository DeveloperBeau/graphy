package cryptobench.ciphers.speck;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class SpeckSuite implements CipherSuite {
    @Override
    public String name() {
        return "speck";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new SpeckCipher(SpeckKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : SpeckVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
