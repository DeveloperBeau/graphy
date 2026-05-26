// feature: top-level function, called cross-file
package com.example

import java.util.Locale

fun formatName(name: String): String {
    return "hi, " + name.trim()
}

fun unrelatedHelper(): Int {
    return 7
}

fun String.toLoud(): String = this.uppercase(Locale.ROOT)
