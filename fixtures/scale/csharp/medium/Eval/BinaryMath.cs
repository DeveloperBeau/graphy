using System;

namespace Calc.Eval
{
    public static class BinaryMath
    {
        public static double Apply(string op, double left, double right)
        {
            switch (op)
            {
                case "+": return left + right;
                case "-": return left - right;
                case "*": return left * right;
                case "/":
                    if (right == 0) throw new EvalError("division by zero", op);
                    return left / right;
                case "%": return left % right;
                case "^": return Math.Pow(left, right);
                default: throw new EvalError("unknown operator", op);
            }
        }
    }
}
