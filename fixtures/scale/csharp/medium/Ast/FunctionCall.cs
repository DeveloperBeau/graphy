using System.Collections.Generic;

namespace Calc.Ast
{
    public class FunctionCall : Node
    {
        public string Name { get; }
        public List<Node> Arguments { get; }

        public FunctionCall(string name, List<Node> arguments)
        {
            Name = name;
            Arguments = arguments;
        }

        public override string Describe()
        {
            var parts = Arguments.ConvertAll(a => a.Describe());
            return Name + "(" + string.Join(", ", parts) + ")";
        }
    }
}
