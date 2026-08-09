package calc.eval

import calc.errors.EvalException

final class FunctionRegistry {
  private var unary = Map.empty[String, Double => Double]
  private var aggregate = Map.empty[String, Array[Double] => Double]

  def addUnary(name: String, fn: Double => Double): Unit =
    unary = unary.updated(name, fn)

  def addAggregate(name: String, fn: Array[Double] => Double): Unit =
    aggregate = aggregate.updated(name, fn)

  def invoke(name: String, args: Array[Double]): Double = {
    if (args.length == 1 && unary.contains(name)) unary(name)(args(0))
    else aggregate.get(name) match {
      case Some(fn) => fn(args)
      case None => throw new EvalException("unknown function " + name + "/" + args.length)
    }
  }

  def knows(name: String): Boolean = unary.contains(name) || aggregate.contains(name)
}
