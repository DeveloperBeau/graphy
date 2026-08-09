package cryptobench.ciphers.keywordsub

class KeywordSubKey {
    final String keyword

    KeywordSubKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    /** Keyword first (duplicates dropped), then the remaining letters in order. */
    String mixedAlphabet() {
        StringBuilder sb = new StringBuilder()
        (keyword + "ABCDEFGHIJKLMNOPQRSTUVWXYZ").each { ch ->
            if (sb.indexOf(ch) < 0) sb.append(ch)
        }
        return sb.toString()
    }

    static KeywordSubKey defaultKey() {
        return new KeywordSubKey("OBSIDIAN")
    }
}
