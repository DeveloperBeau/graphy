namespace Calc.Ast
{
    public class BinaryOp : Node
    {
        public string Op { get; }
        public Node Left { get; }
        public Node Right { get; }

        public BinaryOp(string op, Node left, Node right)
        {
            Op = op;
            Left = left;
            Right = right;
        }

        public override string Describe()
        {
            return "(" + Left.Describe() + " " + Op + " " + Right.Describe() + ")";
        }
    }
}
