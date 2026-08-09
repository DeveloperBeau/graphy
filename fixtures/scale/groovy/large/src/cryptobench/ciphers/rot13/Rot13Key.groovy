package cryptobench.ciphers.rot13

class Rot13Key {
    final int rounds
    Rot13Key(int rounds) {
        this.rounds = rounds
    }

    boolean isIdentity() {
        return rounds % 2 == 0
    }

    static Rot13Key defaultKey() {
        return new Rot13Key(1)
    }
}
