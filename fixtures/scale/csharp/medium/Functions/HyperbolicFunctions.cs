using System;

namespace Calc.Functions
{
    public static class HyperbolicFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("sinh", args => Math.Sinh(args[0]));
            registry.Define("cosh", args => Math.Cosh(args[0]));
            registry.Define("tanh", args => Math.Tanh(args[0]));
        }
    }
}
