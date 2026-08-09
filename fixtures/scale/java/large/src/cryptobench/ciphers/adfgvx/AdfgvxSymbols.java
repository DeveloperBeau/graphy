package cryptobench.ciphers.adfgvx;

/** Substitution between grid cells and ADFGVX symbol pairs. */
class AdfgvxSymbols {
    static final String SYMBOLS = "ADFGVX";

    static String substitute(String grid, String text) {
        StringBuilder sb = new StringBuilder();
        for (char c : text.toCharArray()) {
            int at = grid.indexOf(c);
            if (at >= 0) sb.append(SYMBOLS.charAt(at / 6)).append(SYMBOLS.charAt(at % 6));
        }
        return sb.toString();
    }

    static String unsubstitute(String grid, String symbols) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i + 1 < symbols.length(); i += 2) {
            int row = SYMBOLS.indexOf(symbols.charAt(i));
            int col = SYMBOLS.indexOf(symbols.charAt(i + 1));
            if (row >= 0 && col >= 0) sb.append(grid.charAt(row * 6 + col));
        }
        return sb.toString();
    }
}
