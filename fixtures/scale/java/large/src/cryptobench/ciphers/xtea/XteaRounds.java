package cryptobench.ciphers.xtea;

/** XTEA: TEA with a corrected key schedule mixing. */
class XteaRounds {
    static long encryptBlock(long block, XteaKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 0; r < 32; r++) {
            int sum = 0x9E3779B9 * r;
            v0 += (((v1 << 4) ^ (v1 >>> 5)) + v1) ^ (sum + key.k(sum & 3));
            sum += 0x9E3779B9;
            v1 += (((v0 << 4) ^ (v0 >>> 5)) + v0) ^ (sum + key.k((sum >>> 11) & 3));
        }
        return pack(v0, v1);
    }

    static long decryptBlock(long block, XteaKey key) {
        int v0 = (int) (block >>> 32);
        int v1 = (int) block;
        for (int r = 32 - 1; r >= 0; r--) {
            int sum = 0x9E3779B9 * (r + 1);
            v1 -= (((v0 << 4) ^ (v0 >>> 5)) + v0) ^ (sum + key.k((sum >>> 11) & 3));
            sum -= 0x9E3779B9;
            v0 -= (((v1 << 4) ^ (v1 >>> 5)) + v1) ^ (sum + key.k(sum & 3));
        }
        return pack(v0, v1);
    }

    private static long pack(int v0, int v1) {
        return ((long) v0 << 32) | (v1 & 0xFFFFFFFFL);
    }
}
