package calc.eval;

import calc.ast.AssignExpr;
import calc.ast.BinaryExpr;
import calc.ast.CallExpr;
import calc.ast.Expr;
import calc.ast.NumberExpr;
import calc.ast.UnaryExpr;
import calc.ast.VariableExpr;
import calc.errors.EvalException;
import calc.parser.OperatorTable;

public class Evaluator {
    private final Environment environment;
    private final FunctionRegistry registry;

    public Evaluator(Environment environment, FunctionRegistry registry) {
        this.environment = environment;
        this.registry = registry;
    }

    public double evaluate(Expr expr) {
        if (expr instanceof NumberExpr n) return n.getValue();
        if (expr instanceof VariableExpr v) return environment.lookup(v.getName());
        if (expr instanceof AssignExpr a) {
            double value = evaluate(a.getValue());
            environment.define(a.getName(), value);
            return value;
        }
        if (expr instanceof UnaryExpr u) {
            double inner = evaluate(u.getOperand());
            return u.getOperator() == '-' ? -inner : inner;
        }
        if (expr instanceof BinaryExpr b) return OperatorTable.apply(b.getOperator(), evaluate(b.getLeft()), evaluate(b.getRight()));
        if (expr instanceof CallExpr c) return registry.invoke(c.getFunction(), c.getArguments().stream().mapToDouble(this::evaluate).toArray());
        throw new EvalException("cannot evaluate " + expr.describe());
    }
}
