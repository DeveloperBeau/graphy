package cryptobench.util

class Bytes {
    static byte[] of(String text) {
        return text.getBytes("UTF-8")
    }

    static String toText(byte[] data) {
        return new String(data, "UTF-8")
    }

    static byte[] pad(byte[] data, int blockSize) {
        int rem = data.length % blockSize
        int padding = rem == 0 ? 0 : blockSize - rem
        byte[] out = new byte[data.length + padding]
        System.arraycopy(data, 0, out, 0, data.length)
        return out
    }
}
