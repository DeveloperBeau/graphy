package cryptobench.verify

import cryptobench.core.HashFunction

class Determinism {
    static boolean stable(HashFunction hash, String sample) {
        return hash.digest(sample) == hash.digest(sample)
    }

    static boolean distinct(HashFunction hash, String left, String right) {
        if (left == right) return true
        return hash.digest(left) != hash.digest(right)
    }
}
