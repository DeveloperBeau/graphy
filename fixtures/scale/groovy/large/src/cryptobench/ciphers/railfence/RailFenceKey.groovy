package cryptobench.ciphers.railfence

class RailFenceKey {
    final int rails
    RailFenceKey(int rails) {
        this.rails = rails
    }

    int cycleLength() {
        return 2 * (rails - 1)
    }

    static RailFenceKey defaultKey() {
        return new RailFenceKey(3)
    }
}
