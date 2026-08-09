namespace Calc.Parsing
{
    public static class Precedence
    {
        public static int Of(string op)
        {
            switch (op)
            {
                case "+":
                case "-":
                    return 1;
                case "*":
                case "/":
                case "%":
                    return 2;
                case "^":
                    return 3;
                default:
                    return 0;
            }
        }

        public static bool RightAssociative(string op)
        {
            return op == "^";
        }
    }
}
