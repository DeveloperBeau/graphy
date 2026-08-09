using System;

namespace Calc.Functions
{
    public static class TrigFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("sin", args => Math.Sin(args[0]));
            registry.Define("cos", args => Math.Cos(args[0]));
            registry.Define("tan", args => Math.Tan(args[0]));
            registry.Define("asin", args => Math.Asin(args[0]));
            registry.Define("acos", args => Math.Acos(args[0]));
            registry.Define("atan", args => Math.Atan(args[0]));
        }
    }
}
