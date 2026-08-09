namespace TextPrint.Style
{
    public static class AnsiPalette
    {
        public const string Reset = "\u001b[0m";
        public const string Bold = "\u001b[1m";
        public const string Dim = "\u001b[2m";

        public static string Colored(string body, int code)
        {
            return "\u001b[" + code + "m" + body + Reset;
        }
    }
}
