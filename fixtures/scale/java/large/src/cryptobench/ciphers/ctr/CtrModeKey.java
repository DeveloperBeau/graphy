package cryptobench.ciphers.ctr;

public class CtrModeKey {
    private final long blockKey;

    public CtrModeKey(long blockKey) {
        this.blockKey = blockKey;
    }

    public long getBlockKey() {
        return blockKey;
    }

    public long getNonce() {
        return blockKey ^ 0xC0DEC0DEL;
    }

    public static CtrModeKey defaultKey() {
        return new CtrModeKey(0x5115_ABED_CAFE_D00DL);
    }
}
