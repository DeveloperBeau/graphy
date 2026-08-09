package cryptobench.ciphers.polybius;

public class PolybiusKey {
    private final String seedWord;

    public PolybiusKey(String seedWord) {
        this.seedWord = seedWord.toUpperCase().replace("J", "I");
    }

    /** 25-letter square: seed word first, then the rest of the alphabet minus J. */
    public String square() {
        StringBuilder sb = new StringBuilder();
        String source = seedWord + "ABCDEFGHIKLMNOPQRSTUVWXYZ";
        for (char c : source.toCharArray()) {
            if (c >= 'A' && c <= 'Z' && c != 'J' && sb.indexOf(String.valueOf(c)) < 0) {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    public static PolybiusKey defaultKey() {
        return new PolybiusKey("HARBOR");
    }
}
