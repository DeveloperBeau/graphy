using System;

namespace Calc.Functions
{
    public static class NumberFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("abs", args => Math.Abs(args[0]));
            registry.Define("sign", args => Math.Sign(args[0]));
            registry.Define("clamp", args => Math.Min(Math.Max(args[0], args[1]), args[2]));
        }
    }
}
