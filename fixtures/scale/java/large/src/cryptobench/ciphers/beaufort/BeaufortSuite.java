package cryptobench.ciphers.beaufort;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class BeaufortSuite implements CipherSuite {
    @Override
    public String name() {
        return "beaufort";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new BeaufortCipher(BeaufortKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : BeaufortVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
