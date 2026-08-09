package cryptobench.ciphers.polybius

class PolybiusKey {
    final String seedWord

    PolybiusKey(String seedWord) {
        this.seedWord = seedWord.toUpperCase().replace("J", "I")
    }

    /** 25-letter square: seed word first, then the rest of the alphabet minus J. */
    String square() {
        StringBuilder sb = new StringBuilder()
        (seedWord + "ABCDEFGHIKLMNOPQRSTUVWXYZ").each { ch ->
            if (ch != "J" && sb.indexOf(ch) < 0) sb.append(ch)
        }
        return sb.toString()
    }

    static PolybiusKey defaultKey() {
        return new PolybiusKey("HARBOR")
    }
}
