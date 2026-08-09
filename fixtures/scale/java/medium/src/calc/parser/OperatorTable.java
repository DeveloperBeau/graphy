package calc.parser;

import calc.errors.EvalException;

import static calc.util.DoubleCompare.nearlyZero;

public class OperatorTable {
    public static double apply(char op, double left, double right) {
        switch (op) {
            case '+':
                return left + right;
            case '-':
                return left - right;
            case '*':
                return left * right;
            case '/':
                if (nearlyZero(right)) {
                    throw new EvalException("division by zero");
                }
                return left / right;
            case '%':
                return left % right;
            case '^':
                return Math.pow(left, right);
            default:
                throw new EvalException("unknown operator " + op);
        }
    }
}
