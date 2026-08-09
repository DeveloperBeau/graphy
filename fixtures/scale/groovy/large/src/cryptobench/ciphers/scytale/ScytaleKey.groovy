package cryptobench.ciphers.scytale

class ScytaleKey {
    final int rows
    ScytaleKey(int rows) {
        this.rows = rows
    }

    int circumference() {
        return rows
    }

    static ScytaleKey defaultKey() {
        return new ScytaleKey(4)
    }
}
