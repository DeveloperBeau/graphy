namespace Calc.Ast
{
    public class NumberLiteral : Node
    {
        public double Value { get; }

        public NumberLiteral(double value)
        {
            Value = value;
        }

        public override string Describe()
        {
            return Value.ToString(System.Globalization.CultureInfo.InvariantCulture);
        }
    }
}
