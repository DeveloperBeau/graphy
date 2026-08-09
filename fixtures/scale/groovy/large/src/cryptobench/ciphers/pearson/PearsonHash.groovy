package cryptobench.ciphers.pearson

import cryptobench.core.HashFunction
import cryptobench.util.Bytes
import cryptobench.util.Rng

/** Pearson hashing over a shuffled permutation table. */
class PearsonHash implements HashFunction {
    private final int[] table = buildTable()

    String name() {
        return "pearson"
    }

    long digest(String input) {
        long out = 0
        for (int lane = 0; lane < 8; lane++) {
            int h = lane
            Bytes.of(input).each { b ->
                h = table[(h ^ (b & 0xFF)) & 0xFF]
            }
            out = (out << 8) | h
        }
        return out
    }

    private static int[] buildTable() {
        int[] t = new int[256]
        for (int i = 0; i < 256; i++) t[i] = i
        Rng rng = new Rng(0xBADC0DE)
        for (int i = 255; i > 0; i--) {
            int j = rng.nextInt(i + 1)
            int tmp = t[i]; t[i] = t[j]; t[j] = tmp
        }
        return t
    }
}
