package cryptobench.ciphers.feistel;

import cryptobench.util.BlockCodec;

/** Balanced 16-round Feistel permutation over 8-byte blocks. */
public class FeistelNetwork {
    private final FeistelKey key;

    public FeistelNetwork(FeistelKey key) {
        this.key = key;
    }

    public void block(byte[] data, int off, boolean reverse) {
        long packed = BlockCodec.read(data, off);
        int left = (int) (packed >>> 32);
        int right = (int) packed;
        for (int r = 0; r < 16; r++) {
            int round = reverse ? 15 - r : r;
            int tmp = right;
            right = left ^ round(right, key.subKey(round));
            left = tmp;
        }
        BlockCodec.write(data, off, ((long) right << 32) | (left & 0xFFFFFFFFL));
    }

    private int round(int half, int subKey) {
        int mixed = Integer.rotateLeft(half ^ subKey, 5);
        return mixed * 0x9E3779B9 + subKey;
    }
}
