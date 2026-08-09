package cryptobench.ciphers.myszkowski

class MyszkowskiKey {
    final String keyword
    MyszkowskiKey(String keyword) {
        this.keyword = keyword.toUpperCase()
    }

    boolean hasRepeats() {
        return keyword.toSet().size() < keyword.length()
    }

    static MyszkowskiKey defaultKey() {
        return new MyszkowskiKey("TOMATO")
    }
}
