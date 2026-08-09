using System;
using System.Collections.Generic;
using Calc.Eval;

namespace Calc.Functions
{
    public class FunctionRegistry
    {
        private readonly Dictionary<string, Func<double[], double>> _table =
            new Dictionary<string, Func<double[], double>>();

        public void Define(string name, Func<double[], double> body)
        {
            _table[name] = body;
        }

        public double Invoke(string name, double[] arguments)
        {
            if (!_table.TryGetValue(name, out var body))
            {
                throw new EvalError("unknown function", name);
            }
            return body(arguments);
        }

        public List<string> Names()
        {
            var names = new List<string>(_table.Keys);
            names.Sort();
            return names;
        }
    }
}
