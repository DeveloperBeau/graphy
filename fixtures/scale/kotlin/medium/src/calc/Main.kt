package calc

import calc.io.banner
import calc.repl.Repl
import calc.repl.Session
import kotlin.system.exitProcess

fun main() {
    println(banner())
    val session = Session()
    val repl = Repl(session)
    exitProcess(repl.loop())
}
