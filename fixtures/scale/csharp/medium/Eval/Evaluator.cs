using Calc.Ast;
using Calc.Functions;

namespace Calc.Eval
{
    public class Evaluator
    {
        private readonly Environment _environment;
        private readonly FunctionRegistry _functions;

        public Evaluator(Environment environment, FunctionRegistry functions)
        {
            _environment = environment;
            _functions = functions;
        }

        public double Eval(Node node)
        {
            switch (node)
            {
                case NumberLiteral number: return number.Value;
                case VariableRef variable: return _environment.Resolve(variable.Name);
                case UnaryOp unary: return -Eval(unary.Operand);
                case BinaryOp binary:
                    return BinaryMath.Apply(binary.Op, Eval(binary.Left), Eval(binary.Right));
                case FunctionCall call:
                    var arguments = call.Arguments.ConvertAll(Eval);
                    return _functions.Invoke(call.Name, arguments.ToArray());
                case Assignment assignment:
                    var assigned = Eval(assignment.Value);
                    _environment.Assign(assignment.Name, assigned);
                    return assigned;
                default:
                    throw new EvalError("unsupported node", node.Describe());
            }
        }
    }
}
