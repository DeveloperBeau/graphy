package cryptobench.ciphers.foursquare;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class FourSquareSuite implements CipherSuite {
    @Override
    public String name() {
        return "foursquare";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new FourSquareCipher(FourSquareKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : FourSquareVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
