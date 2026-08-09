package calc.ast;

/**
 * Marker for every node the parser can produce. Evaluation lives in
 * calc.eval.Evaluator so the tree stays a plain data structure.
 */
public interface Expr {
    /** Short human-readable form used by :history and error messages. */
    default String describe() {
        return getClass().getSimpleName();
    }
}
