package cryptobench.ciphers.cbc

import cryptobench.ciphers.feistel.FeistelNetwork

/** Applies CBC chaining around the Feistel block permutation. */
class CbcChain {
    static void encrypt(FeistelNetwork network, byte[] data, byte[] chain) {
        for (int off = 0; off < data.length; off += 8) {
            for (int i = 0; i < 8; i++) data[off + i] = (data[off + i] ^ chain[i]) as byte
            network.block(data, off, false)
            System.arraycopy(data, off, chain, 0, 8)
        }
    }

    static void decrypt(FeistelNetwork network, byte[] data, byte[] chain) {
        for (int off = 0; off < data.length; off += 8) {
            byte[] next = java.util.Arrays.copyOfRange(data, off, off + 8)
            network.block(data, off, true)
            for (int i = 0; i < 8; i++) data[off + i] = (data[off + i] ^ chain[i]) as byte
            System.arraycopy(next, 0, chain, 0, 8)
        }
    }
}
