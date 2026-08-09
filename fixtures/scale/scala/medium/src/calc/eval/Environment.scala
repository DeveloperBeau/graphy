package calc.eval

import scala.collection.immutable.TreeMap

import calc.errors.EvalException

final class Environment {
  private var variables = TreeMap.empty[String, Double]

  def define(name: String, value: Double): Unit =
    variables = variables.updated(name, value)

  def lookup(name: String): Double =
    variables.getOrElse(name, throw new EvalException("unknown variable " + name))

  def isDefined(name: String): Boolean = variables.contains(name)

  def names: Iterable[String] = variables.keys
}
