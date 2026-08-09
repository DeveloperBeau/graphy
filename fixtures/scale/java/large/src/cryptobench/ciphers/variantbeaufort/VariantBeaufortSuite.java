package cryptobench.ciphers.variantbeaufort;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class VariantBeaufortSuite implements CipherSuite {
    @Override
    public String name() {
        return "variantbeaufort";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new VariantBeaufortCipher(VariantBeaufortKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : VariantBeaufortVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
