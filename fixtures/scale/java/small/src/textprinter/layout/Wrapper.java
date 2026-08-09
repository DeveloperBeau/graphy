package textprinter.layout;

import java.util.ArrayList;
import java.util.List;

public class Wrapper {
    public static List<String> wrap(String line, int width) {
        List<String> wrapped = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        for (String word : line.split(" ")) {
            if (current.length() > 0 && current.length() + 1 + word.length() > width) {
                wrapped.add(current.toString());
                current.setLength(0);
            }
            if (current.length() > 0) {
                current.append(' ');
            }
            current.append(word);
        }
        if (current.length() > 0) {
            wrapped.add(current.toString());
        }
        if (wrapped.isEmpty()) {
            wrapped.add("");
        }
        return wrapped;
    }
}
