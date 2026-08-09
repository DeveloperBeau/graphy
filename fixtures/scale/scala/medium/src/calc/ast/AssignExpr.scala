package calc.ast

final case class AssignExpr(name: String, value: Expr) extends Expr {

  override def describe: String = name + " = " + value.describe

  def isSelfReference: Boolean = value match {
    case VariableExpr(other) => other == name
    case _                   => false
  }
}
