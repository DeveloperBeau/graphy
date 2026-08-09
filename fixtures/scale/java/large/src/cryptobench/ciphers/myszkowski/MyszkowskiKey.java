package cryptobench.ciphers.myszkowski;

public class MyszkowskiKey {
    private final String keyword;

    public MyszkowskiKey(String keyword) {
        this.keyword = keyword.toUpperCase();
    }

    public String getKeyword() {
        return keyword;
    }

    public static MyszkowskiKey defaultKey() {
        return new MyszkowskiKey("TOMATO");
    }
}
