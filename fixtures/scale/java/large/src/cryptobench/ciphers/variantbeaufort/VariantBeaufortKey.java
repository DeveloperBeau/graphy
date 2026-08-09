package cryptobench.ciphers.variantbeaufort;

public class VariantBeaufortKey {
    private final String keyword;

    public VariantBeaufortKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    public String getKeyword() {
        return keyword;
    }

    public char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length());
    }

    public static VariantBeaufortKey defaultKey() {
        return new VariantBeaufortKey("COBALT");
    }
}
