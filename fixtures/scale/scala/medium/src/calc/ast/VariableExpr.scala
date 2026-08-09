package calc.ast

final case class VariableExpr(name: String) extends Expr {

  override def describe: String = name

  def isConstantName: Boolean =
    VariableExpr.ConstantNames.contains(name)
}

object VariableExpr {
  private val ConstantNames = Set("pi", "e", "phi", "tau")
}
