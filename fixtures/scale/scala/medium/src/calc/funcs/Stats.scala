package calc.funcs

import calc.eval.FunctionRegistry

object Stats {
  def register(registry: FunctionRegistry): Unit = {
    registry.addAggregate("min", _.min)
    registry.addAggregate("max", _.max)
    registry.addAggregate("sum", _.sum)
    registry.addAggregate("mean", mean)
    registry.addAggregate("stddev", stddev)
  }

  private[funcs] def mean(args: Array[Double]): Double = args.sum / args.length

  private[funcs] def stddev(args: Array[Double]): Double = {
    val m = mean(args)
    val sumSquares = args.map(x => (x - m) * (x - m)).sum
    math.sqrt(sumSquares / math.max(1, args.length - 1))
  }
}
