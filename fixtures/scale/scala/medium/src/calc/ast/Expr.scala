package calc.ast

/**
 * Marker for every node the parser can produce. Evaluation lives in
 * calc.eval.Evaluator so the tree stays plain data.
 */
sealed trait Expr {
  /** Short human-readable form used by :history and error messages. */
  def describe: String = getClass.getSimpleName
}

object Expr {
  def isLeaf(expr: Expr): Boolean = expr match {
    case _: NumberExpr | _: VariableExpr => true
    case _                               => false
  }
}
