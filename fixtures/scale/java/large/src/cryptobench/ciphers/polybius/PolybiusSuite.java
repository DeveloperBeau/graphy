package cryptobench.ciphers.polybius;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class PolybiusSuite implements CipherSuite {
    @Override
    public String name() {
        return "polybius";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new PolybiusCipher(PolybiusKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : PolybiusVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
