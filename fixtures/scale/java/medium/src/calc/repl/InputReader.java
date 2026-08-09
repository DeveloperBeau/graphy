package calc.repl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class InputReader {
    private final BufferedReader reader;

    public InputReader(InputStream in) {
        this.reader = new BufferedReader(new InputStreamReader(in));
    }

    public String nextLine() {
        try {
            return reader.readLine();
        } catch (IOException e) {
            return null;
        }
    }
}
