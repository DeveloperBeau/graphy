namespace Calc.Ast
{
    public class UnaryOp : Node
    {
        public string Operator { get; }
        public Node Operand { get; }

        public UnaryOp(string op, Node operand)
        {
            Operator = op;
            Operand = operand;
        }

        public override string Describe()
        {
            return Operator + Operand.Describe();
        }
    }
}
