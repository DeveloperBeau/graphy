package cryptobench.ciphers.scytale;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class ScytaleSuite implements CipherSuite {
    @Override
    public String name() {
        return "scytale";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new ScytaleCipher(ScytaleKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : ScytaleVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
