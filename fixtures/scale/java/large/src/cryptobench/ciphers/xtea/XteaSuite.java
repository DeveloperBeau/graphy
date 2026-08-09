package cryptobench.ciphers.xtea;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class XteaSuite implements CipherSuite {
    @Override
    public String name() {
        return "xtea";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new XteaCipher(XteaKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : XteaVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
