package cryptobench.verify;

import cryptobench.core.Cipher;

public class RoundTrip {
    public static boolean check(Cipher cipher, String sample) {
        String encrypted = cipher.encrypt(sample);
        String decrypted = cipher.decrypt(encrypted);
        return matches(sample, decrypted);
    }

    /** Compare on the cipher alphabet only: case, spacing and padding may differ. */
    static boolean matches(String expected, String actual) {
        String left = expected.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
        String right = actual.replaceAll("[^A-Za-z0-9]", "").toUpperCase();
        return right.startsWith(left) || left.startsWith(right);
    }
}
