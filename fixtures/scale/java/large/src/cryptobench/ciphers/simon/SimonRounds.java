package cryptobench.ciphers.simon;

/** Simon64-style Feistel rounds built from AND, rotate and xor. */
class SimonRounds {
    static long encryptBlock(long block, SimonKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 0; r < 32; r++) {
            int tmp = v0;
            v0 = v1 ^ (Integer.rotateLeft(v0, 1) & Integer.rotateLeft(v0, 8)) ^ Integer.rotateLeft(v0, 2) ^ key.k(r & 3);
            v1 = tmp;
        }
        return pack(v0, v1);
    }

    static long decryptBlock(long block, SimonKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 32 - 1; r >= 0; r--) {
            int tmp = v1;
            v1 = v0 ^ (Integer.rotateLeft(v1, 1) & Integer.rotateLeft(v1, 8)) ^ Integer.rotateLeft(v1, 2) ^ key.k(r & 3);
            v0 = tmp;
        }
        return pack(v0, v1);
    }

    private static long pack(int v0, int v1) {
        return ((long) v0 << 32) | (v1 & 0xFFFFFFFFL);
    }
}
