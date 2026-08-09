package calc.funcs

import calc.eval.Environment

object Constants {
  val Phi: Double = (1 + math.sqrt(5)) / 2
  val Tau: Double = 2 * math.Pi

  def seed(environment: Environment): Unit = {
    environment.define("pi", math.Pi)
    environment.define("e", math.E)
    environment.define("phi", Phi)
    environment.define("tau", Tau)
  }
}
