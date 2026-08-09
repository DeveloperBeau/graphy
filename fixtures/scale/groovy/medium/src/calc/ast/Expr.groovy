package calc.ast

/**
 * Marker for every node the parser can produce. Evaluation lives in
 * calc.eval.Evaluator so the tree stays plain data.
 */
interface Expr {
    /** Short human-readable form used by :history and error messages. */
    String describe()
}
