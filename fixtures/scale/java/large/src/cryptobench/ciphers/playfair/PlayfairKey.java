package cryptobench.ciphers.playfair;

public class PlayfairKey {
    private final String keyword;

    public PlayfairKey(String keyword) {
        this.keyword = keyword.toUpperCase().replace("J", "I");
    }

    public String square() {
        StringBuilder sb = new StringBuilder();
        String source = keyword + "ABCDEFGHIKLMNOPQRSTUVWXYZ";
        for (char c : source.toCharArray()) {
            if (c >= 'A' && c <= 'Z' && c != 'J' && sb.indexOf(String.valueOf(c)) < 0) {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    public static PlayfairKey defaultKey() {
        return new PlayfairKey("MONARCHY");
    }
}
