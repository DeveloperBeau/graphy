package cryptobench.ciphers.rc4;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class Rc4Suite implements CipherSuite {
    @Override
    public String name() {
        return "rc4";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new Rc4Cipher(Rc4Key.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : Rc4Vectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
