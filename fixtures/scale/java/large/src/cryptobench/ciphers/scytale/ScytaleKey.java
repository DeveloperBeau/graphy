package cryptobench.ciphers.scytale;

public class ScytaleKey {
    private final int rows;

    public ScytaleKey(int rows) {
        this.rows = rows;
    }

    public int getRows() {
        return rows;
    }

    public static ScytaleKey defaultKey() {
        return new ScytaleKey(4);
    }
}
