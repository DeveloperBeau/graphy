package cryptobench.ciphers.twosquare;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class TwoSquareSuite implements CipherSuite {
    @Override
    public String name() {
        return "twosquare";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new TwoSquareCipher(TwoSquareKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : TwoSquareVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
