package cryptobench.ciphers.vigenere;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class VigenereSuite implements CipherSuite {
    @Override
    public String name() {
        return "vigenere";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new VigenereCipher(VigenereKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : VigenereVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
