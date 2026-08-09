package cryptobench.ciphers.autokey

class AutokeyKey {
    final String primer
    AutokeyKey(String primer) {
        this.primer = primer.toUpperCase()
    }

    int primerLength() {
        return primer.length()
    }

    static AutokeyKey defaultKey() {
        return new AutokeyKey("EMBER")
    }
}
