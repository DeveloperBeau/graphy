package cryptobench.ciphers.adfgvx;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class AdfgvxSuite implements CipherSuite {
    @Override
    public String name() {
        return "adfgvx";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new AdfgvxCipher(AdfgvxKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : AdfgvxVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
