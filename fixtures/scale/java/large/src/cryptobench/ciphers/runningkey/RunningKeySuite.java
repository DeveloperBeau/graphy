package cryptobench.ciphers.runningkey;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class RunningKeySuite implements CipherSuite {
    @Override
    public String name() {
        return "runningkey";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new RunningKeyCipher(RunningKeyKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : RunningKeyVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
