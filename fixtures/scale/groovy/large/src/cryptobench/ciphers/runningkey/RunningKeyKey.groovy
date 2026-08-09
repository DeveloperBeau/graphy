package cryptobench.ciphers.runningkey

class RunningKeyKey {
    private static final String PASSAGE =
        "ITWASABRIGHTCOLDDAYINAPRILANDTHECLOCKSWERESTRIKINGTHIRTEEN"

    final String stream

    RunningKeyKey(String stream) {
        this.stream = stream.toUpperCase()
    }

    char keyCharAt(int position) {
        return stream.charAt(position % stream.length())
    }

    static RunningKeyKey defaultKey() {
        return new RunningKeyKey(PASSAGE)
    }
}
