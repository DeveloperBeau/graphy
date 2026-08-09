package cryptobench.ciphers.cbc;

public class CbcModeKey {
    private final long blockKey;

    public CbcModeKey(long blockKey) {
        this.blockKey = blockKey;
    }

    public long getBlockKey() {
        return blockKey;
    }

    public byte[] iv() {
        byte[] iv = new byte[8];
        long v = blockKey * 0x9E3779B97F4A7C15L;
        for (int i = 7; i >= 0; i--) { iv[i] = (byte) v; v >>>= 8; }
        return iv;
    }

    public static CbcModeKey defaultKey() {
        return new CbcModeKey(0x5115_ABED_CAFE_D00DL);
    }
}
