package cryptobench.report

fun formatRow(name: String, passed: Int, failed: Int, millis: Double): String =
    String.format("%-18s %5d %5d %9.2fms", name, passed, failed, millis)

fun tableHeader(): String =
    String.format("%-18s %5s %5s %11s", "suite", "pass", "fail", "elapsed")

/** Separator sized to match the header columns. */
fun tableRule(): String = "-".repeat(42)
