package calc.parser

import calc.errors.EvalException
import calc.util.DoubleCompare

class OperatorTable {
    static double apply(char op, double left, double right) {
        switch (op) {
            case '+' as char: return left + right
            case '-' as char: return left - right
            case '*' as char: return left * right
            case '/' as char:
                if (DoubleCompare.nearlyZero(right)) throw new EvalException("division by zero")
                return left / right
            case '%' as char: return left % right
            case '^' as char: return Math.pow(left, right)
            default: throw new EvalException("unknown operator " + op)
        }
    }
}
