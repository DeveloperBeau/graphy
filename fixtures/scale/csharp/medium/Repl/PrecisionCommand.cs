namespace Calc.Repl
{
    public static class PrecisionCommand
    {
        public static string Run(ReplContext context, string[] parts)
        {
            if (parts.Length < 2 || !int.TryParse(parts[1], out var digits))
            {
                return "precision is " + context.Settings.Precision;
            }
            context.Settings.Precision = digits;
            return "precision set to " + digits;
        }
    }
}
