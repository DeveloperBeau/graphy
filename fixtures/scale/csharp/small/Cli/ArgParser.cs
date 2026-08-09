namespace TextPrint.Cli
{
    public static class ArgParser
    {
        public static Options Parse(string[] args)
        {
            var options = Options.Defaults();
            for (var i = 0; i < args.Length; i++)
            {
                switch (args[i])
                {
                    case "--width":
                        options.Width = int.Parse(args[++i]);
                        break;
                    case "--align":
                        options.Align = args[++i];
                        break;
                    case "--border":
                        options.BorderStyle = args[++i];
                        break;
                    case "--theme":
                        options.ThemeName = args[++i];
                        break;
                    case "--help":
                        options.ShowHelp = true;
                        break;
                }
            }
            return options;
        }
    }
}
