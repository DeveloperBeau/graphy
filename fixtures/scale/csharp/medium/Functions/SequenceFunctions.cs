namespace Calc.Functions
{
    public static class SequenceFunctions
    {
        public static void Install(FunctionRegistry registry)
        {
            registry.Define("fact", args => Factorial((int)args[0]));
            registry.Define("fib", args => Fibonacci((int)args[0]));
        }

        private static double Factorial(int n)
        {
            double result = 1;
            for (var i = 2; i <= n; i++) result *= i;
            return result;
        }

        private static double Fibonacci(int n)
        {
            double a = 0, b = 1;
            for (var i = 0; i < n; i++)
            {
                var next = a + b;
                a = b;
                b = next;
            }
            return a;
        }
    }
}
