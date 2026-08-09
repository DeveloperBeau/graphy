package cryptobench.ciphers.tea;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class TeaSuite implements CipherSuite {
    @Override
    public String name() {
        return "tea";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new TeaCipher(TeaKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : TeaVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
