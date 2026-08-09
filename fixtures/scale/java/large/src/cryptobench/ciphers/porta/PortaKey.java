package cryptobench.ciphers.porta;

public class PortaKey {
    private final String keyword;

    public PortaKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    public String getKeyword() {
        return keyword;
    }

    public char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length());
    }

    public static PortaKey defaultKey() {
        return new PortaKey("MERIDIAN");
    }
}
