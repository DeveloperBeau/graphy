package cryptobench.ciphers.feistel

import cryptobench.util.BlockCodec

/** Balanced 16-round Feistel permutation over 8-byte blocks. */
class FeistelNetwork {
    private final FeistelKey key

    FeistelNetwork(FeistelKey key) {
        this.key = key
    }

    void block(byte[] data, int off, boolean reverse) {
        long packed = BlockCodec.read(data, off)
        int left = (packed >>> 32) as int
        int right = packed as int
        for (int r = 0; r < 16; r++) {
            int round = reverse ? 15 - r : r
            int tmp = right
            right = left ^ roundFn(right, key.subKey(round))
            left = tmp
        }
        BlockCodec.write(data, off, ((right as long) << 32) | (left & 0xFFFFFFFFL))
    }

    private int roundFn(int half, int subKey) {
        int mixed = Integer.rotateLeft(half ^ subKey, 5)
        return mixed * 0x1E3779B9 + subKey
    }
}
