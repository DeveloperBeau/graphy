package cryptobench.ciphers.cbc;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class CbcModeSuite implements CipherSuite {
    @Override
    public String name() {
        return "cbc";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new CbcModeCipher(CbcModeKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : CbcModeVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
