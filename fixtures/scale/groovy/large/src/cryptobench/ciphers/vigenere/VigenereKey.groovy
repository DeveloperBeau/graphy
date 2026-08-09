package cryptobench.ciphers.vigenere

class VigenereKey {
    final String keyword
    VigenereKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    char keyCharAt(int position) {
        return keyword.charAt(position % keyword.length())
    }

    static VigenereKey defaultKey() {
        return new VigenereKey("LANTERN")
    }
}
