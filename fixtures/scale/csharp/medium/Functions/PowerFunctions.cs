using System;

namespace Calc.Functions
{
    public static class PowerFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("sqrt", args => Math.Sqrt(args[0]));
            registry.Define("cbrt", args => Math.Cbrt(args[0]));
            registry.Define("pow", args => Math.Pow(args[0], args[1]));
            registry.Define("hypot", args => Math.Sqrt(args[0] * args[0] + args[1] * args[1]));
        }
    }
}
