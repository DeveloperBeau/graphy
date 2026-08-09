package cryptobench.ciphers.lcg;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class LcgSuite implements CipherSuite {
    @Override
    public String name() {
        return "lcg";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new LcgCipher(LcgKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : LcgVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
