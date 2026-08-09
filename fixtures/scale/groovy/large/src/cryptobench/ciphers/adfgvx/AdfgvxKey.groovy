package cryptobench.ciphers.adfgvx

class AdfgvxKey {
    final String seedWord
    final String transpositionWord

    AdfgvxKey(String seedWord, String transpositionWord) {
        this.seedWord = seedWord.toUpperCase()
        this.transpositionWord = transpositionWord
    }

    /** 36-cell grid of letters and digits, seed word first. */
    String grid() {
        StringBuilder sb = new StringBuilder()
        (seedWord + "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").each { ch ->
            if (sb.indexOf(ch) < 0) sb.append(ch)
        }
        return sb.toString()
    }

    static AdfgvxKey defaultKey() {
        return new AdfgvxKey("NIGHTMARE", "GERMAN")
    }
}
