package cryptobench.live

import java.io.PrintStream

class ConsoleSink(private val out: PrintStream) {

    fun line(text: String) {
        out.println(text)
    }

    fun transientLine(text: String) {
        out.print("\r" + text)
        out.flush()
    }
}
