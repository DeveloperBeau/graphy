using System;

namespace Calc.Functions
{
    public static class RoundingFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("round", args => Math.Round(args[0]));
            registry.Define("floor", args => Math.Floor(args[0]));
            registry.Define("ceil", args => Math.Ceiling(args[0]));
            registry.Define("trunc", args => Math.Truncate(args[0]));
        }
    }
}
