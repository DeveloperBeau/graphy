package cryptobench.ciphers.ctr;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class CtrModeSuite implements CipherSuite {
    @Override
    public String name() {
        return "ctr";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new CtrModeCipher(CtrModeKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : CtrModeVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
