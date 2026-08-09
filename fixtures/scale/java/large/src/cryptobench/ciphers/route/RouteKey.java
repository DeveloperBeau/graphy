package cryptobench.ciphers.route;

public class RouteKey {
    private final int width;

    public RouteKey(int width) {
        this.width = width;
    }

    public int getWidth() {
        return width;
    }

    public static RouteKey defaultKey() {
        return new RouteKey(6);
    }
}
