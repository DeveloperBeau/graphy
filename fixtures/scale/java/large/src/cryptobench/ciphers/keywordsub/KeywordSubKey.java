package cryptobench.ciphers.keywordsub;

public class KeywordSubKey {
    private final String keyword;

    public KeywordSubKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    /** Keyword first (duplicates dropped), then the remaining letters in order. */
    public String mixedAlphabet() {
        StringBuilder sb = new StringBuilder();
        String source = keyword + "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        for (char c : source.toCharArray()) {
            if (c >= 'A' && c <= 'Z' && sb.indexOf(String.valueOf(c)) < 0) {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    public static KeywordSubKey defaultKey() {
        return new KeywordSubKey("OBSIDIAN");
    }
}
