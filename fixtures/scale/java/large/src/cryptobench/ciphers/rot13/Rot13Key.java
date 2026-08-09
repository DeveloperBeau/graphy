package cryptobench.ciphers.rot13;

public class Rot13Key {
    private final int rounds;

    public Rot13Key(int rounds) {
        this.rounds = rounds;
    }

    public int getRounds() {
        return rounds;
    }

    public static Rot13Key defaultKey() {
        return new Rot13Key(1);
    }
}
