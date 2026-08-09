package cryptobench.ciphers.playfair

/** Splits cleaned text into Playfair digraphs, breaking doubles with X. */
class PlayfairDigraphs {
    static String split(String text) {
        String folded = text.replace('J', 'I')
        StringBuilder sb = new StringBuilder()
        int i = 0
        while (i < folded.length()) {
            char first = folded.charAt(i)
            sb.append(first)
            if (i + 1 < folded.length() && folded.charAt(i + 1) != first) {
                sb.append(folded.charAt(i + 1))
                i += 2
            } else {
                sb.append(first == ('X' as char) ? 'Q' : 'X')
                i += 1
            }
        }
        return sb.toString()
    }
}
