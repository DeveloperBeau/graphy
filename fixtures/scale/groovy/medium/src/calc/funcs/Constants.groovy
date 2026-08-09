package calc.funcs

import calc.eval.Environment

class Constants {
    static final double PHI = (1 + Math.sqrt(5)) / 2
    static final double TAU = 2 * Math.PI

    static void seed(Environment environment) {
        environment.define("pi", Math.PI)
        environment.define("e", Math.E)
        environment.define("phi", PHI)
        environment.define("tau", TAU)
    }
}
