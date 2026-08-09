package calc.ast

final case class CallExpr(function: String, arguments: List[Expr]) extends Expr {

  override def describe: String = function + "/" + arguments.size

  def arity: Int = arguments.size

  def isNullary: Boolean = arguments.isEmpty
}
