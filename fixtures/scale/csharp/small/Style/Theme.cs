using TextPrint.Style;

namespace TextPrint.Style
{
    public class Theme
    {
        public string Name { get; private set; }
        public string Prefix { get; private set; }

        public static Theme Named(string name)
        {
            var theme = new Theme { Name = name, Prefix = "" };
            if (name == "bright")
            {
                theme.Prefix = AnsiPalette.Bold;
            }
            else if (name == "mono")
            {
                theme.Prefix = AnsiPalette.Dim;
            }
            return theme;
        }

        public string Apply(string body)
        {
            if (Prefix.Length == 0)
            {
                return body;
            }
            return Prefix + body + AnsiPalette.Reset;
        }
    }
}
