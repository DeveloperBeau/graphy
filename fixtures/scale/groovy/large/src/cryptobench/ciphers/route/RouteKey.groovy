package cryptobench.ciphers.route

class RouteKey {
    final int width
    RouteKey(int width) {
        this.width = width
    }

    int rowCountFor(int length) {
        return (length + width - 1).intdiv(width)
    }

    static RouteKey defaultKey() {
        return new RouteKey(6)
    }
}
