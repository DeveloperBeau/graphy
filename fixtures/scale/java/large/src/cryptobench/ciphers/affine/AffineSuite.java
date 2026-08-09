package cryptobench.ciphers.affine;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class AffineSuite implements CipherSuite {
    @Override
    public String name() {
        return "affine";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new AffineCipher(AffineKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : AffineVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
