package cryptobench.ciphers.atbash

class AtbashKey {
    final String label
    AtbashKey(String label) {
        this.label = label
    }

    String describe() {
        return "atbash/" + label
    }

    static AtbashKey defaultKey() {
        return new AtbashKey("fixed")
    }
}
