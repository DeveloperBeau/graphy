package cryptobench.ciphers.tea;

/** Tiny Encryption Algorithm with the classic 32-cycle schedule. */
class TeaRounds {
    static long encryptBlock(long block, TeaKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 0; r < 32; r++) {
            int sum = 0x9E3779B9 * (r + 1);
            v0 += ((v1 << 4) + key.k(0)) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k(1));
            v1 += ((v0 << 4) + key.k(2)) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k(3));
        }
        return pack(v0, v1);
    }

    static long decryptBlock(long block, TeaKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 32 - 1; r >= 0; r--) {
            int sum = 0x9E3779B9 * (r + 1);
            v1 -= ((v0 << 4) + key.k(2)) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k(3));
            v0 -= ((v1 << 4) + key.k(0)) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k(1));
        }
        return pack(v0, v1);
    }

    private static long pack(int v0, int v1) {
        return ((long) v0 << 32) | (v1 & 0xFFFFFFFFL);
    }
}
