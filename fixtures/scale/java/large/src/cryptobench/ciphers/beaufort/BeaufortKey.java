package cryptobench.ciphers.beaufort;

public class BeaufortKey {
    private final String keyword;

    public BeaufortKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    public String getKeyword() {
        return keyword;
    }

    public char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length());
    }

    public static BeaufortKey defaultKey() {
        return new BeaufortKey("GRANITE");
    }
}
