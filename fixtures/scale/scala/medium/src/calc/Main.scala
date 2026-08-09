package calc

import calc.io.Banner
import calc.repl.Repl
import calc.repl.Session

object Main {
  def main(args: Array[String]): Unit = {
    println(Banner.render)
    val session = new Session
    val repl = new Repl(session)
    sys.exit(repl.loop())
  }
}
