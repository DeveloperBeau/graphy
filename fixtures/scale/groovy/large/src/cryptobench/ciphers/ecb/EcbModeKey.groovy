package cryptobench.ciphers.ecb

class EcbModeKey {
    final long blockKey
    EcbModeKey(long blockKey) {
        this.blockKey = blockKey
    }

    EcbModeKey rotated() {
        return new EcbModeKey(Long.rotateLeft(blockKey, 8))
    }

    static EcbModeKey defaultKey() {
        return new EcbModeKey(0x5115ABED)
    }
}
