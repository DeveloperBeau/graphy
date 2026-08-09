package cryptobench.ciphers.ecb;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class EcbModeSuite implements CipherSuite {
    @Override
    public String name() {
        return "ecb";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new EcbModeCipher(EcbModeKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : EcbModeVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
