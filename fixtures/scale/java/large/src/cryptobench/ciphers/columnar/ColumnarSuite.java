package cryptobench.ciphers.columnar;

import cryptobench.core.Cipher;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.verify.RoundTrip;

public class ColumnarSuite implements CipherSuite {
    @Override
    public String name() {
        return "columnar";
    }

    @Override
    public SuiteResult run() {
        Cipher cipher = new ColumnarCipher(ColumnarKey.defaultKey());
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : ColumnarVectors.samples()) {
            if (RoundTrip.check(cipher, sample)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
