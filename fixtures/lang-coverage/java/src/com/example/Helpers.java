// feature: top-level static methods, called cross-file
package com.example;

import java.util.Locale;

public class Helpers {
    public static String formatName(String name) {
        return "hi, " + name.trim();
    }

    public static int unrelatedHelper() {
        return 7;
    }
}
