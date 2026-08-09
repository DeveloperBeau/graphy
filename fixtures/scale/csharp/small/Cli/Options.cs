namespace TextPrint.Cli
{
    public class Options
    {
        public int Width { get; set; } = 60;
        public string Align { get; set; } = "left";
        public string BorderStyle { get; set; } = "single";
        public string ThemeName { get; set; } = "plain";
        public bool ShowHelp { get; set; }

        public static Options Defaults()
        {
            return new Options();
        }
    }
}
