namespace Calc.Ast
{
    public class VariableRef : Node
    {
        public string Name { get; }

        public VariableRef(string name)
        {
            Name = name;
        }

        public override string Describe()
        {
            return Name;
        }
    }
}
