package textprinter.model

class Document {
    final List<String> lines

    private Document(List<String> lines) {
        this.lines = lines
    }

    static Document fromText(String text) {
        List<String> lines = text.split("\n").collect { it.replaceAll(/\s+\$/, "") }
        return new Document(lines)
    }

    int longestLine() {
        return lines.isEmpty() ? 0 : lines*.length().max()
    }
}
