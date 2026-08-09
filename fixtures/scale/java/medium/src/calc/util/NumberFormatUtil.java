package calc.util;

public class NumberFormatUtil {
    public static String trimTrailingZeros(String formatted) {
        if (!formatted.contains(".")) {
            return formatted;
        }
        String trimmed = formatted;
        while (trimmed.endsWith("0")) {
            trimmed = trimmed.substring(0, trimmed.length() - 1);
        }
        if (trimmed.endsWith(".")) {
            trimmed = trimmed.substring(0, trimmed.length() - 1);
        }
        return trimmed;
    }

    public static String grouped(long value) {
        return String.format("%,d", value);
    }
}
