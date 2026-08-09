using System;

namespace Calc.Functions
{
    public static class LogFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("ln", args => Math.Log(args[0]));
            registry.Define("log10", args => Math.Log10(args[0]));
            registry.Define("log2", args => Math.Log2(args[0]));
            registry.Define("exp", args => Math.Exp(args[0]));
        }
    }
}
