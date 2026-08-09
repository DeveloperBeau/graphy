package cryptobench.ciphers.columnar;

public class ColumnarKey {
    private final String keyword;

    public ColumnarKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    /** Column indexes sorted by their keyword letter, ties left to right. */
    public int[] columnOrder() {
        int n = keyword.length();
        int[] order = new int[n];
        int at = 0;
        for (char letter = 'A'; letter <= 'Z'; letter++) {
            for (int i = 0; i < n; i++) {
                if (keyword.charAt(i) == letter) {
                    order[at++] = i;
                }
            }
        }
        return order;
    }

    /** Pads with X until the text fills whole rows. */
    public String padded(String text) {
        StringBuilder sb = new StringBuilder(text);
        while (sb.length() % keyword.length() != 0) sb.append('X');
        return sb.toString();
    }

    public static ColumnarKey defaultKey() {
        return new ColumnarKey("ZEBRAS");
    }
}
