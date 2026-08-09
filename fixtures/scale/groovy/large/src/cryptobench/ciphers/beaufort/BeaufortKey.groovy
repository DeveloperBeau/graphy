package cryptobench.ciphers.beaufort

class BeaufortKey {
    final String keyword
    BeaufortKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length())
    }

    static BeaufortKey defaultKey() {
        return new BeaufortKey("GRANITE")
    }
}
