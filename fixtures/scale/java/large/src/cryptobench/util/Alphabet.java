package cryptobench.util;

public class Alphabet {
    public static final int SIZE = 26;

    public static boolean isUpper(char c) {
        return c >= 'A' && c <= 'Z';
    }

    public static int indexOf(char c) {
        return c - 'A';
    }

    public static char charAt(int index) {
        return (char) ('A' + Math.floorMod(index, SIZE));
    }

    public static String clean(String text) {
        StringBuilder sb = new StringBuilder();
        for (char c : text.toUpperCase().toCharArray()) {
            if (isUpper(c)) {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
