package cryptobench.ciphers.ctr

class CtrModeKey {
    final long blockKey
    CtrModeKey(long blockKey) {
        this.blockKey = blockKey
    }

    long nonce() {
        return blockKey ^ 0xC0DEC0DE
    }

    static CtrModeKey defaultKey() {
        return new CtrModeKey(0x5115ABED)
    }
}
