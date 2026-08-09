package cryptobench.ciphers.fnv1a;

import java.util.List;

import cryptobench.core.CipherSuite;
import cryptobench.core.HashFunction;
import cryptobench.core.SuiteResult;
import cryptobench.verify.Determinism;

public class Fnv1aSuite implements CipherSuite {
    @Override
    public String name() {
        return "fnv1a";
    }

    @Override
    public String category() {
        return "hash";
    }

    @Override
    public SuiteResult run() {
        HashFunction hash = new Fnv1aHash();
        List<String> samples = Fnv1aVectors.samples();
        int passed = 0;
        int failed = 0;
        long start = System.nanoTime();
        for (String sample : samples) {
            if (Determinism.stable(hash, sample)) passed++; else failed++;
        }
        for (String other : samples) {
            if (Determinism.distinct(hash, samples.get(0), other)) passed++; else failed++;
        }
        return new SuiteResult(name(), passed, failed, System.nanoTime() - start);
    }
}
