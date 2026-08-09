package cryptobench.ciphers.bifid

class BifidKey {
    final String seedWord
    BifidKey(String seedWord) {
        this.seedWord = seedWord
    }

    int seedLength() {
        return seedWord.length()
    }

    static BifidKey defaultKey() {
        return new BifidKey("CIPHER")
    }
}
