package cryptobench.ciphers.xorshift;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class XorShiftSuite implements CipherSuite {
    @Override
    public String name() {
        return "xorshift";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new XorShiftCipher(XorShiftKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : XorShiftVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
