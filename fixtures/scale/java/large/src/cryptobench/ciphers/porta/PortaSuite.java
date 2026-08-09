package cryptobench.ciphers.porta;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class PortaSuite implements CipherSuite {
    @Override
    public String name() {
        return "porta";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new PortaCipher(PortaKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : PortaVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
