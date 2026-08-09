namespace CipherLab.Cli
{
    public static class ArgParser
    {
        public static Config Parse(string[] args)
        {
            var config = Config.Defaults();
            for (var i = 0; i < args.Length; i++)
            {
                if (args[i] == "--iterations" && i + 1 < args.Length)
                {
                    config.Iterations = int.Parse(args[++i]);
                }
                else if (args[i] == "--suite" && i + 1 < args.Length)
                {
                    config.SuiteFilter = args[++i];
                }
                else if (args[i] == "--no-persist")
                {
                    config.Persist = false;
                }
            }
            return config;
        }
    }
}
