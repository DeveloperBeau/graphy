package cryptobench.ciphers.playfair

/** The three Playfair digraph rules: same row, same column, rectangle. */
class PlayfairRules {
    static String transform(String square, String pairs, int step) {
        StringBuilder sb = new StringBuilder()
        int i = 0
        while (i + 1 < pairs.length()) {
            int a = square.indexOf(pairs.charAt(i))
            int b = square.indexOf(pairs.charAt(i + 1))
            if (a.intdiv(5) == b.intdiv(5)) {
                sb.append(square.charAt(a.intdiv(5) * 5 + (a + step) % 5))
                sb.append(square.charAt(b.intdiv(5) * 5 + (b + step) % 5))
            } else if (a % 5 == b % 5) {
                sb.append(square.charAt((a + step * 5) % 25 / 5 * 5 + a % 5))
                sb.append(square.charAt((b + step * 5) % 25 / 5 * 5 + b % 5))
            } else {
                sb.append(square.charAt(a.intdiv(5) * 5 + b % 5))
                sb.append(square.charAt(b.intdiv(5) * 5 + a % 5))
            }
            i += 2
        }
        return sb.toString()
    }
}
