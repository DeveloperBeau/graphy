package cryptobench.ciphers.myszkowski;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class MyszkowskiSuite implements CipherSuite {
    @Override
    public String name() {
        return "myszkowski";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new MyszkowskiCipher(MyszkowskiKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : MyszkowskiVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
