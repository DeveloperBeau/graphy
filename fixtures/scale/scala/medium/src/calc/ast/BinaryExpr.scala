package calc.ast

final case class BinaryExpr(operator: Char, left: Expr, right: Expr) extends Expr {

  override def describe: String =
    "(" + left.describe + " " + operator + " " + right.describe + ")"

  def operandCount: Int = 2

  def swapped: BinaryExpr = BinaryExpr(operator, right, left)
}
