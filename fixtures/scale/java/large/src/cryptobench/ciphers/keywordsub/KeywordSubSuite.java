package cryptobench.ciphers.keywordsub;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class KeywordSubSuite implements CipherSuite {
    @Override
    public String name() {
        return "keywordsub";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new KeywordSubCipher(KeywordSubKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : KeywordSubVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
