package cryptobench.ciphers.runningkey;

public class RunningKeyKey {
    private static final String PASSAGE =
            "ITWASABRIGHTCOLDDAYINAPRILANDTHECLOCKSWERESTRIKINGTHIRTEEN";

    private final String stream;

    public RunningKeyKey(String stream) {
        this.stream = stream.toUpperCase();
    }

    public char keyCharAt(int position) {
        return stream.charAt(position % stream.length());
    }

    public static RunningKeyKey defaultKey() {
        return new RunningKeyKey(PASSAGE);
    }
}
