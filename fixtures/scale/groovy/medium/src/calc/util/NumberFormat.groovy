package calc.util

class NumberFormat {
    static String trimTrailingZeros(String formatted) {
        if (!formatted.contains(".")) return formatted
        String trimmed = formatted
        while (trimmed.endsWith("0")) trimmed = trimmed[0..-2]
        if (trimmed.endsWith(".")) trimmed = trimmed[0..-2]
        return trimmed
    }

    static String grouped(long value) {
        return String.format("%,d", value)
    }
}
