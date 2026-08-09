package cryptobench.ciphers.ecb;

public class EcbModeKey {
    private final long blockKey;

    public EcbModeKey(long blockKey) {
        this.blockKey = blockKey;
    }

    public long getBlockKey() {
        return blockKey;
    }

    public static EcbModeKey defaultKey() {
        return new EcbModeKey(0x5115_ABED_CAFE_D00DL);
    }
}
