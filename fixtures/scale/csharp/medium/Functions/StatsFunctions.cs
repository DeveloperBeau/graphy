using System;
using System.Linq;

namespace Calc.Functions
{
    public static class StatsFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("min", args => args.Min());
            registry.Define("max", args => args.Max());
            registry.Define("sum", args => args.Sum());
            registry.Define("mean", args => args.Average());
            registry.Define("range", args => args.Max() - args.Min());
        }
    }
}
