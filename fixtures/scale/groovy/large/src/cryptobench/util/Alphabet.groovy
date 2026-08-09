package cryptobench.util

class Alphabet {
    static final int SIZE = 26

    static boolean isUpper(char c) {
        return c >= ('A' as char) && c <= ('Z' as char)
    }

    static int indexOf(char c) {
        return c - ('A' as char)
    }

    static char charAt(int index) {
        return (('A' as char) + Math.floorMod(index, SIZE)) as char
    }

    static String clean(String text) {
        StringBuilder sb = new StringBuilder()
        text.toUpperCase().each { ch ->
            char c = ch as char
            if (isUpper(c)) sb.append(c)
        }
        return sb.toString()
    }
}
