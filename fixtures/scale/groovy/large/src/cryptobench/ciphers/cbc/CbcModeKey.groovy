package cryptobench.ciphers.cbc

class CbcModeKey {
    final long blockKey

    CbcModeKey(long blockKey) {
        this.blockKey = blockKey
    }

    byte[] iv() {
        byte[] out = new byte[8]
        long v = blockKey * 0x1E3779B9
        for (int i = 7; i >= 0; i--) {
            out[i] = v as byte
            v = v >>> 8
        }
        return out
    }

    static CbcModeKey defaultKey() {
        return new CbcModeKey(0x5115ABED)
    }
}
