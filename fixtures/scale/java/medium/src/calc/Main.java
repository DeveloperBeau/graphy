package calc;

import calc.io.Banner;
import calc.repl.Repl;
import calc.repl.Session;

public class Main {
    public static void main(String[] args) {
        System.out.println(Banner.render());
        Session session = new Session();
        Repl repl = new Repl(session);
        int status = repl.loop(System.in, System.out);
        System.exit(status);
    }
}
