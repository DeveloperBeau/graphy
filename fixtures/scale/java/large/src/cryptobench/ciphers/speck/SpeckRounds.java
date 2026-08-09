package cryptobench.ciphers.speck;

/** Speck64-style ARX rounds: rotate, add, xor. */
class SpeckRounds {
    static long encryptBlock(long block, SpeckKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 0; r < 27; r++) {
            v0 = (Integer.rotateRight(v0, 8) + v1) ^ key.k(r & 3);
            v1 = Integer.rotateLeft(v1, 3) ^ v0;
        }
        return pack(v0, v1);
    }

    static long decryptBlock(long block, SpeckKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 27 - 1; r >= 0; r--) {
            v1 = Integer.rotateRight(v1 ^ v0, 3);
            v0 = Integer.rotateLeft((v0 ^ key.k(r & 3)) - v1, 8);
        }
        return pack(v0, v1);
    }

    private static long pack(int v0, int v1) {
        return ((long) v0 << 32) | (v1 & 0xFFFFFFFFL);
    }
}
