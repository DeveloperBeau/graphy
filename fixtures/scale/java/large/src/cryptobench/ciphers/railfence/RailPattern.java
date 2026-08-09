package cryptobench.ciphers.railfence;

/** Maps character positions onto rails of the zigzag fence. */
class RailPattern {
    private final int rails;

    RailPattern(int rails) {
        this.rails = rails;
    }

    int railCount() {
        return rails;
    }

    int railFor(int index) {
        int cycle = 2 * (rails - 1);
        int pos = index % cycle;
        return pos < rails ? pos : cycle - pos;
    }
}
