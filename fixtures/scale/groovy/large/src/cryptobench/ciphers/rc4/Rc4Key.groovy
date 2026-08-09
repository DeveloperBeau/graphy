package cryptobench.ciphers.rc4

class Rc4Key {
    final String secret
    Rc4Key(String secret) {
        this.secret = secret
    }

    int secretLength() {
        return secret.length()
    }

    static Rc4Key defaultKey() {
        return new Rc4Key("quiet-basalt-9")
    }
}
