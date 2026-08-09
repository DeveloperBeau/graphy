package cryptobench.ciphers.columnar

class ColumnarKey {
    final String keyword

    ColumnarKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    /** Column indexes sorted by their keyword letter, ties left to right. */
    int[] columnOrder() {
        int n = keyword.length()
        int[] order = new int[n]
        int at = 0
        for (char letter = 'A' as char; letter <= ('Z' as char); letter++) {
            for (int i = 0; i < n; i++) {
                if (keyword.charAt(i) == letter) order[at++] = i
            }
        }
        return order
    }

    /** Pads with X until the text fills whole rows. */
    String padded(String text) {
        StringBuilder sb = new StringBuilder(text)
        while (sb.length() % keyword.length() != 0) sb.append('X')
        return sb.toString()
    }

    static ColumnarKey defaultKey() {
        return new ColumnarKey("ZEBRAS")
    }
}
