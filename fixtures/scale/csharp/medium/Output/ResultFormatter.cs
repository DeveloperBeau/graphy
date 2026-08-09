namespace Calc.Output
{
    public static class ResultFormatter
    {
        public static string FormatResult(double value, Settings settings)
        {
            var body = NumberFormat.Format(value, settings.Precision);
            return "= " + body;
        }

        public static string FormatError(string kind, string detail)
        {
            return "! " + kind + ": " + detail;
        }
    }
}
