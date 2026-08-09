package cryptobench.ciphers.playfair

class PlayfairKey {
    final String keyword

    PlayfairKey(String keyword) {
        this.keyword = keyword.toUpperCase().replace("J", "I")
    }

    String square() {
        StringBuilder sb = new StringBuilder()
        (keyword + "ABCDEFGHIKLMNOPQRSTUVWXYZ").each { ch ->
            if (ch != "J" && sb.indexOf(ch) < 0) sb.append(ch)
        }
        return sb.toString()
    }

    static PlayfairKey defaultKey() {
        return new PlayfairKey("MONARCHY")
    }
}
