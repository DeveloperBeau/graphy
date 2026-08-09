package cryptobench.ciphers.ctr;

import cryptobench.ciphers.feistel.FeistelNetwork;
import cryptobench.util.BlockCodec;

/** Generates the counter keystream and xors it over the data. */
class CtrKeystream {
    static byte[] mask(FeistelNetwork network, long nonce, byte[] data) {
        byte[] out = new byte[data.length];
        for (int off = 0; off < data.length; off += 8) {
            byte[] counter = new byte[8];
            BlockCodec.write(counter, 0, nonce + off / 8);
            network.block(counter, 0, false);
            for (int i = 0; i < 8 && off + i < data.length; i++) {
                out[off + i] = (byte) (data[off + i] ^ counter[i]);
            }
        }
        return out;
    }
}
