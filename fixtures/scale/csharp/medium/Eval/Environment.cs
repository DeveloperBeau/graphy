using System.Collections.Generic;

namespace Calc.Eval
{
    public class Environment
    {
        private readonly Dictionary<string, double> _variables = new Dictionary<string, double>();

        public void Assign(string name, double value)
        {
            _variables[name] = value;
        }

        public double Resolve(string name)
        {
            if (_variables.TryGetValue(name, out var value))
            {
                return value;
            }
            throw new EvalError("unknown variable", name);
        }

        public List<string> Names()
        {
            var names = new List<string>(_variables.Keys);
            names.Sort();
            return names;
        }
    }
}
