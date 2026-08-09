package cryptobench.ciphers.hill;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class HillSuite implements CipherSuite {
    @Override
    public String name() {
        return "hill";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new HillCipher(HillKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : HillVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
