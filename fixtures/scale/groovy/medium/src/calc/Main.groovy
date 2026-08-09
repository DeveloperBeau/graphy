package calc

import calc.io.Banner
import calc.repl.Repl
import calc.repl.Session

class Main {
    static void main(String[] args) {
        println Banner.render()
        Session session = new Session()
        Repl repl = new Repl(session)
        System.exit(repl.loop())
    }
}
