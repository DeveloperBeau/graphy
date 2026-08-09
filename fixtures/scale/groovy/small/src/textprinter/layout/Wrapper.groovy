package textprinter.layout

class Wrapper {
    static List<String> wrap(String line, int width) {
        List<String> wrapped = []
        StringBuilder current = new StringBuilder()
        line.split(" ").each { word ->
            if (current.length() > 0 && current.length() + 1 + word.length() > width) {
                wrapped << current.toString()
                current.setLength(0)
            }
            if (current.length() > 0) current.append(' ')
            current.append(word)
        }
        if (current.length() > 0) wrapped << current.toString()
        return wrapped.isEmpty() ? [""] : wrapped
    }
}
