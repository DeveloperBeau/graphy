package cryptobench.ciphers.xorcipher;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class XorCipherSuite implements CipherSuite {
    @Override
    public String name() {
        return "xorcipher";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new XorCipherCipher(XorCipherKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : XorCipherVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
