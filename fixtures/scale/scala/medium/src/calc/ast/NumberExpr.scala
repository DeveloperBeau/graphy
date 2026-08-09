package calc.ast

final case class NumberExpr(value: Double) extends Expr {

  override def describe: String = value.toString
}

object NumberExpr {
  val Zero: NumberExpr = NumberExpr(0.0)
}
