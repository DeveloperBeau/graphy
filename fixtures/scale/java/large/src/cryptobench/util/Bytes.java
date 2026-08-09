package cryptobench.util;

import java.nio.charset.StandardCharsets;

public class Bytes {
    public static byte[] of(String text) {
        return text.getBytes(StandardCharsets.UTF_8);
    }

    public static String toText(byte[] data) {
        return new String(data, StandardCharsets.UTF_8);
    }

    public static byte[] pad(byte[] data, int blockSize) {
        int rem = data.length % blockSize;
        int padding = rem == 0 ? 0 : blockSize - rem;
        byte[] out = new byte[data.length + padding];
        System.arraycopy(data, 0, out, 0, data.length);
        return out;
    }
}
