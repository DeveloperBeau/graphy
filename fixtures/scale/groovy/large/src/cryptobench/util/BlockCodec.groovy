package cryptobench.util

/** Big-endian 64-bit block packing shared by the block ciphers. */
class BlockCodec {
    static long read(byte[] data, int at) {
        long value = 0
        for (int i = 0; i < 8; i++) {
            value = (value << 8) | (data[at + i] & 0xFF)
        }
        return value
    }

    static void write(byte[] data, int at, long value) {
        long v = value
        for (int i = 7; i >= 0; i--) {
            data[at + i] = v as byte
            v = v >>> 8
        }
    }
}
