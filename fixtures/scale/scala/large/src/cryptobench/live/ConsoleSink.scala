package cryptobench.live

import java.io.PrintStream

final class ConsoleSink(out: PrintStream) {

  def line(text: String): Unit = out.println(text)

  def transientLine(text: String): Unit = {
    out.print("\r" + text)
    out.flush()
  }
}
