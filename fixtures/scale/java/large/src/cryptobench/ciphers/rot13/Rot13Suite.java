package cryptobench.ciphers.rot13;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class Rot13Suite implements CipherSuite {
    @Override
    public String name() {
        return "rot13";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new Rot13Cipher(Rot13Key.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : Rot13Vectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
