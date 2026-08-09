package cryptobench.ciphers.rc4;

public class Rc4Key {
    private final String secret;

    public Rc4Key(String secret) {
        this.secret = secret;
    }

    public String getSecret() {
        return secret;
    }

    public static Rc4Key defaultKey() {
        return new Rc4Key("quiet-basalt-9");
    }
}
