package cryptobench.ciphers.porta

class PortaKey {
    final String keyword
    PortaKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length())
    }

    static PortaKey defaultKey() {
        return new PortaKey("MERIDIAN")
    }
}
