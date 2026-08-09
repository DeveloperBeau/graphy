package cryptobench.ciphers.caesar;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class CaesarSuite implements CipherSuite {
    @Override
    public String name() {
        return "caesar";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new CaesarCipher(CaesarKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : CaesarVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
