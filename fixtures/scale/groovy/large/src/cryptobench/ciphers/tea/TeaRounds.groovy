package cryptobench.ciphers.tea

/** Tiny Encryption Algorithm with the classic 32-cycle schedule. */
class TeaRounds {
    static long encryptBlock(long block, TeaKey key) {
        int v0 = (block >>> 32) as int
        int v1 = block as int
        for (int r = 0; r < 32; r++) {
            int sum = 0x1E3779B9 * (r + 1)
            v0 += ((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k1)
            v1 += ((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k3)
        }
        return pack(v0, v1)
    }

    static long decryptBlock(long block, TeaKey key) {
        int v0 = (block >>> 32) as int
        int v1 = block as int
        for (int r = 32 - 1; r >= 0; r--) {
            int sum = 0x1E3779B9 * (r + 1)
            v1 -= ((v0 << 4) + key.k2) ^ (v0 + sum) ^ ((v0 >>> 5) + key.k3)
            v0 -= ((v1 << 4) + key.k0) ^ (v1 + sum) ^ ((v1 >>> 5) + key.k1)
        }
        return pack(v0, v1)
    }

    private static long pack(int v0, int v1) {
        return ((v0 as long) << 32) | (v1 & 0xFFFFFFFFL)
    }
}
