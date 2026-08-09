package cryptobench.ciphers.gronsfeld;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class GronsfeldSuite implements CipherSuite {
    @Override
    public String name() {
        return "gronsfeld";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new GronsfeldCipher(GronsfeldKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : GronsfeldVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
