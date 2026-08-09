namespace Calc.Ast
{
    public class Assignment : Node
    {
        public string Name { get; }
        public Node Value { get; }

        public Assignment(string name, Node value)
        {
            Name = name;
            Value = value;
        }

        public override string Describe()
        {
            return Name + " = " + Value.Describe();
        }
    }
}
