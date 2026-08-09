package cryptobench.ciphers.gronsfeld;

public class GronsfeldKey {
    private final String digits;

    public GronsfeldKey(String digits) {
        this.digits = digits;
    }

    public int digitAt(int position) {
        return digits.charAt(position % digits.length()) - '0';
    }

    public char keyCharAt(int position) {
        return digits.charAt(position % digits.length());
    }

    public static GronsfeldKey defaultKey() {
        return new GronsfeldKey("31415");
    }
}
