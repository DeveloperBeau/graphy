package textprinter.model;

import java.util.ArrayList;
import java.util.List;

public class Document {
    private final List<String> lines;

    private Document(List<String> lines) {
        this.lines = lines;
    }

    public static Document fromText(String text) {
        List<String> lines = new ArrayList<>();
        for (String line : text.split("\\n")) {
            lines.add(line.stripTrailing());
        }
        return new Document(lines);
    }

    public List<String> getLines() {
        return lines;
    }

    public int longestLine() {
        int longest = 0;
        for (String line : lines) {
            longest = Math.max(longest, line.length());
        }
        return longest;
    }
}
