package cryptobench.util;

/** Big-endian 64-bit block packing shared by the block ciphers. */
public class BlockCodec {
    public static long read(byte[] data, int at) {
        long value = 0;
        for (int i = 0; i < 8; i++) {
            value = (value << 8) | (data[at + i] & 0xFF);
        }
        return value;
    }

    public static void write(byte[] data, int at, long value) {
        for (int i = 7; i >= 0; i--) {
            data[at + i] = (byte) value;
            value >>>= 8;
        }
    }
}
