package calc.ast

final case class UnaryExpr(operator: Char, operand: Expr) extends Expr {

  override def describe: String = operator.toString + operand.describe

  def isNegation: Boolean = operator == '-'

  def unwrapped: Expr = operand
}
