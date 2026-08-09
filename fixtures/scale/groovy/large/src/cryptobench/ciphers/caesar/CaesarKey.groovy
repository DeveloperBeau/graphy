package cryptobench.ciphers.caesar

class CaesarKey {
    final int shift
    CaesarKey(int shift) {
        this.shift = shift
    }

    int normalizedShift() {
        return ((shift % 26) + 26) % 26
    }

    static CaesarKey defaultKey() {
        return new CaesarKey(7)
    }
}
