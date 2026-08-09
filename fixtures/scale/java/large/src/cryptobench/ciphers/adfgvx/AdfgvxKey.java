package cryptobench.ciphers.adfgvx;

public class AdfgvxKey {
    private final String seedWord;
    private final String transpositionWord;

    public AdfgvxKey(String seedWord, String transpositionWord) {
        this.seedWord = seedWord.toUpperCase();
        this.transpositionWord = transpositionWord;
    }

    /** 36-cell grid of letters and digits, seed word first. */
    public String grid() {
        StringBuilder sb = new StringBuilder();
        String source = seedWord + "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        for (char c : source.toCharArray()) {
            if (sb.indexOf(String.valueOf(c)) < 0) {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    public String getTranspositionWord() {
        return transpositionWord;
    }

    public static AdfgvxKey defaultKey() {
        return new AdfgvxKey("NIGHTMARE", "GERMAN");
    }
}
