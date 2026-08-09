package cryptobench.verify;

import cryptobench.core.HashFunction;

public class Determinism {
    public static boolean stable(HashFunction hash, String sample) {
        return hash.digest(sample) == hash.digest(sample);
    }

    public static boolean distinct(HashFunction hash, String left, String right) {
        if (left.equals(right)) {
            return true;
        }
        return hash.digest(left) != hash.digest(right);
    }
}
