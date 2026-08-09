namespace Calc.Ast
{
    public abstract class Node
    {
        public abstract string Describe();

        public override string ToString()
        {
            return Describe();
        }
    }
}
