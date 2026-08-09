package cryptobench.ciphers.bifid;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class BifidSuite implements CipherSuite {
    @Override
    public String name() {
        return "bifid";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new BifidCipher(BifidKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : BifidVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
