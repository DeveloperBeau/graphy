package cryptobench.ciphers.xorcipher

class XorCipherKey {
    final String phrase
    XorCipherKey(String phrase) {
        this.phrase = phrase
    }

    int phraseLength() {
        return phrase.length()
    }

    static XorCipherKey defaultKey() {
        return new XorCipherKey("drift-anchor-22")
    }
}
